import json, os, sys
from algoliasearch.search.client import SearchClientSync

SEARCH_JSON = os.getenv("SEARCH_JSON", "docs/search.json")
APP_ID      = os.getenv("ALGOLIA_APP_ID", "JZ1UWSSI1E")
INDEX_NAME  = os.getenv("ALGOLIA_INDEX_NAME", "my-website")
ADMIN_KEY   = os.getenv("ALGOLIA_ADMIN_KEY")
MIN_RECORDS = int(os.getenv("ALGOLIA_MIN_RECORDS", "50"))       # wipe-protection floor
MAX_BYTES   = int(os.getenv("ALGOLIA_MAX_RECORD_BYTES", "10000"))  # Algolia's recommended record size
DRY_RUN     = "--dry-run" in sys.argv


def record_bytes(r):
    # Match what Algolia measures: true UTF-8 byte size of the record JSON.
    return len(json.dumps(r, ensure_ascii=False).encode("utf-8"))


def fit_record(r):
    """Shrink the `text` field (only) so the *serialized* record fits MAX_BYTES.
    Binary-searches on character count and re-measures each candidate, so it's exact
    regardless of JSON escaping / multibyte chars. Keeps objectID/href/title/section
    intact so the hit still renders and links correctly. Returns (record, truncated?)."""
    if record_bytes(r) <= MAX_BYTES:
        return r, False
    text = r.get("text", "")
    lo, hi = 0, len(text)                                # keep text[:lo] chars
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if record_bytes({**r, "text": text[:mid] + " …"}) <= MAX_BYTES:
            lo = mid
        else:
            hi = mid - 1
    return {**r, "text": text[:lo] + " …"}, True


with open(SEARCH_JSON) as f:
    records = json.load(f)

# Safety: never let a broken/empty render blow away the live index.
if not isinstance(records, list) or len(records) < MIN_RECORDS:
    sys.exit(f"Refusing to sync: only {len(records)} records (< {MIN_RECORDS}).")
assert len({r['objectID'] for r in records}) == len(records), "duplicate objectID"

records, truncated = zip(*(fit_record(r) for r in records))
records = list(records)
n_trunc = sum(truncated)
if n_trunc:
    print(f"Truncated {n_trunc} oversized record(s) to <= {MAX_BYTES} bytes:")
    for r, t in zip(records, truncated):
        if t:
            print(f"  - {r['objectID']}")

print(f"{len(records)} records -> index '{INDEX_NAME}' (app {APP_ID}), dry_run={DRY_RUN}")
if DRY_RUN:
    sys.exit(0)
if not ADMIN_KEY:
    sys.exit("ALGOLIA_ADMIN_KEY not set.")

client = SearchClientSync(APP_ID, ADMIN_KEY)
try:
    client.replace_all_objects(INDEX_NAME, records)  # atomic, preserves settings/rules/synonyms
finally:
    client.close()
print("Algolia sync complete.")

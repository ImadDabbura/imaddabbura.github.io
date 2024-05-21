class BPETokenizer:
    """Byte-pair encoder."""

    def __init__(self, vocab_sz: int):
        """
        Args:
            vocab_sz (int): Vocabulary size.
        """
        self.vocab_sz = vocab_sz
        self.vocab = {}
        self.merges = {}

    def train(self, text: Iterable[str]):
        """Train Byte-pair encoder."""
        ids = list(text.encode("utf-8"))
        for i in range(256, self.vocab_sz):
            stats = self._get_stats(ids)
            pair = max(stats, key=stats.get)
            idx = i
            self.merges[pair] = idx
            ids = self._merge(ids, pair, idx)
        self.vocab = self._build_vocab(ids)

    def encode(self, text):
        """Encode string to bytes using vocabulary built during training."""
        ids = list(text.encode("utf-8"))

        # If text is empty or has one character -> it is already encoded from previous step
        while len(ids) >= 2:
            # stats is used only for getting pairs next to each other
            stats = self._get_stats(ids)
            # Because we built vocab (and merges) bottom-up, we need to encode
            # idx from smallest index because some later pairs depend on pairs
            # occured before
            # If a pair doesn't exist, it wouldn't participate in the list
            pair = min(stats, key=lambda p: self.merges.get(p, float("inf")))
            if pair not in self.merges:
                break  # No more pairs to merge
            idx = self.merges[pair]
            ids = self._merge(ids, pair, idx)
        return ids

    def decode(self, tokens: Iterable[int]):
        """Decode tokens into string using the vocabulary built during training."""
        tokens = b"".join(self.vocab[idx] for idx in tokens)
        # It is important to replace tokens that were not seen during training
        # with `?`; otherwise, it would fail
        return tokens.decode("utf-8", errors="replace")

    def _get_stats(self, ids: Iterable[int]):
        """Get pair counts."""
        counts = {}
        for pair in zip(ids, ids[1:]):
            counts[pair] = counts.get(pair, 0) + 1
        return counts

    def _merge(self, ids: Iterable[int], pair: Iterable[int], idx: int):
        """Merge pairs that match `pair` with new index `idx`."""
        newids = []
        i = 0
        while i < len(ids):
            if i < len(ids) - 1 and tuple(pair) == tuple(ids[i : i + 2]):
                newids.append(idx)
                i += 2
            else:
                newids.append(ids[i])
                i += 1
        return newids

    def _build_vocab(self, ids: Iterable[int]):
        """Build vocabulary from 0-255 bytes and merges."""
        vocab = {idx: bytes([idx]) for idx in range(256)}
        # Here we assume the items returned would be in the same order they were inserted. This is Okay starting in Python 3.10
        for (p0, p1), idx in self.merges.items():
            # This would be a concatenation of the bytes
            vocab[idx] = vocab[p0] + vocab[p1]
        return vocab

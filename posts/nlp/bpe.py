from typing import Iterable


class BPETokenizer:
    """Byte-pair encoding tokenizer."""

    def __init__(self):
        self.merges = {}
        self.vocab = {}

    def _get_stats(self, ids: Iterable[int]):
        counts = {}
        for pair in zip(ids[:-1], ids[1:]):
            counts[pair] = counts.get(pair, 0) + 1
        return counts

    def _merge(self, ids: Iterable[int], pair: tuple[int, int], idx: int):
        newids = []
        i = 0
        while i < len(ids):
            if i < len(ids) - 1 and tuple(ids[i : i + 2]) == pair:
                newids.append(idx)
                i += 2
            else:
                newids.append(ids[i])
                i += 1
        return newids

    def _build_vocab(self):
        pass

    def train(self, text: Iterable[str]):
        pass

    def encode(self, text: str):
        pass

    def decode(self, ids: Iterable[int]):
        pass

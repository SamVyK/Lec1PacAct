import sys
from collections import Counter

VOWELS = set("aeiou")

def count_vowels(file_path: str):
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            text = f.read().lower()
        c = Counter(ch for ch in text if ch in VOWELS)
        result = {v: c.get(v, 0) for v in ["a", "e", "i", "o", "u"]}
        return result
    except FileNotFoundError:
        print(f"[error] File not found: {file_path}", file=sys.stderr)
        sys.exit(1)

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 frequency.py <file_path>", file=sys.stderr)
        sys.exit(2)
    file_path = sys.argv[1]
    result = count_vowels(file_path)
    out = " ".join([f"{k}={v}" for k, v in result.items()])
    print(out)

if __name__ == "__main__":
    main()

import hashlib
import os

BUF_SIZE = 65536


class Hasher:
    def __init__(self, folder_path, hash_algo):
        self.folder_path = folder_path
        self.hash_algo = hash_algo
        self.folder_hash = self.get_hash()

    def get_hash(self):
        try:
            hasher = hashlib.new(self.hash_algo)
        except Exception as e:
            raise ValueError("Unsupported hash algorithm chosen. " + e)

        for root, dirs, files in os.walk(self.folder_path):
            for file in files:
                with open(os.path.join(root, file), "rb") as f:
                    file_data = f.read(BUF_SIZE)
                    while len(file_data) > 0:
                        hasher.update(file_data)
                        file_data = f.read(BUF_SIZE)
            for dir_to_hash in dirs:
                hasher.update(dir_to_hash.encode("utf-8"))
        return hasher.hexdigest()

    def set_hash_algo(self):
        pass

    def set_folder_path(self):
        pass

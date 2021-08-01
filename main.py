# https://www.youtube.com/watch?v=pYasYyjByKI
import hashlib


class NeuralCoinBlock:

    def __init__(self, previous_block_hash, transaction_list):
        self.previous_block_hash = previous_block_hash
        self.transaction_list = transaction_list

        self.block_data = "-".join(transaction_list) + '-' + previous_block_hash
        self.block_hash = hashlib.sha256(self.block_data.encode()).hexdigest()


t1 = "Anna sends 2 NC to Mike"
t2 = "Bob sends 4.3 NC to Mike"
t3 = "Mike sends 3.3 NC to Bob"
t4 = "Danie sends 0.3 NC to Anna"
t5 = "Mike sends 1 NC to Charlie"
t6 = "Mike sends 5.4 NC to Danie"

initial_block = NeuralCoinBlock("Initial String", [t1, t2])
print(f'{initial_block.block_data}')
print(f'{initial_block.block_hash}\n')

second_Block = NeuralCoinBlock(initial_block.block_hash, [t3, t4])
print(f'{second_Block.block_data}')
print(f'{second_Block.block_hash}\n')

third_Block = NeuralCoinBlock(second_Block.block_hash, [t5, t6])
print(f'{third_Block.block_data}')
print(f'{third_Block.block_hash}\n')

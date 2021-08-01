from uuid import uuid4
import datetime
from fastecdsa import curve, ecdsa, keys


class Account:
    def generate_private_key(self):
        private_key = keys.gen_private_key(curve.secp256k1)
        self.private_key = private_key
        return private_key

    def generate_public_key(self, private_key):
        public_key = keys.get_public_key(private_key, curve.secp256k1)
        return public_key

    def create_transaction(self, data):
        transaction_id = str(uuid4()).replace('-', '')
        timestamp = str(datetime.datetime.now())
        transaction = {'transaction_id': transaction_id, 'timestamp': timestamp, 'data': data}
        return transaction

    def get_signature(self, transaction, private):
        sha256 = ecdsa.sha256
        secp256k1 = curve.secp256k1
        signature = ecdsa.sign(transaction, private, secp256k1, sha256)
        return signature






account = Account()


pvt =account.generate_private_key()
# pubk = account.generate_public_key(pvt)
#
# print('The private Key: ')
# print(pvt)
#
# print('The public Key: ')
# print(pubk)








# text = 'this is a beautiful day'
# trans = account.create_transaction(text)
# signature = account.get_signature(trans, pvt)
# print('transaction - ')
# print(trans)
# print("Signature - ")
# print(signature)





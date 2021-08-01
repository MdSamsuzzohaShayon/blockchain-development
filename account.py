from uuid import uuid4
from fastecdsa import curve, ecdsa, keys


class Account:
    def generate_private_key(self):
        private_key = keys.gen_private_key(curve.secp256k1)
        self.private_key = private_key
        return private_key

    def generate_public_key(self, private_key):
        public_key = keys.get_public_key(private_key, curve.secp256k1)
        return public_key


account = Account()


# pvt =account.generate_private_key()
# pubk = account.generate_public_key(pvt)
#
# print('The private Key: ')
# print(pvt)
#
# print('The public Key: ')
# print(pubk)


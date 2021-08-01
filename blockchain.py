# https://www.youtube.com/watch?v=URjVp7Bf1vc

import datetime

import hashlib
import json
from flask import Flask, jsonify, request
import requests
from uuid import uuid4
from urllib.parse import urlparse
from fastecdsa import curve, ecdsa, keys
import zmq
import threading


# from flask_mysql import MySQL


class Blockchain:
    def create_genesis_block(self):
        the_time = datetime.datetime.now()
        block = {}
        block['index'] = 1
        block['prev_hash'] = '00000000'
        block['nonce'] = 456
        block['data'] = "this is the cenesis block of"
        block['timestamp'] = the_time.strftime('%Y-%m-%d %H:%M:%S.%f')

        encoded_block = json.dumps(block, sort_keys=True).encode()
        new_hash = hashlib.sha256(encoded_block).hexdigest()
        block['new_hash'] = new_hash




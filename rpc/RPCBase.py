
import asyncore
import socket
import struct
import zlib
import json

NET_CMD_UNKOWN              = 0
NET_CMD_KEEPALIVE           = 1
NET_CMD_QUOTER              = 2
NET_CMD_RPC                 = 3
NET_CMD_NOTIFICATION        = 4
NET_CMD_VSS_MARKET_STATUS   = 5
NET_CMD_VSS_QUOTE           = 6

COMPRESS_NONE               = 0
COMPRESS_ZLIB               = 1
COMPRESS_DOUBLE_ZLIB        = 2

class TTPackage :
    def __init__(self, seq = 0, cmd = 0, data = {}):
        self.packLen = 0
        self.seq = seq
        self.cmd = cmd
        self.data = data

    def encode_withFormat(self, encodeFormat):
        if encodeFormat == "json":
            jsonData = json.dumps(self.data)
            length = len(jsonData)
            packLen = length + 12
            intSeq = int(self.seq)
            flagSeq = ((self.seq >> 32) & 0x0f) << 8
            tag = flagSeq
            datas = struct.pack("!IIHH%ds" % length, packLen, intSeq, self.cmd, tag, jsonData)
            return datas

    def decode_withFormat(self, data, decodeFormat):
        self.packLen,  = struct.unpack_from("!I", data, 0)
        self.seq, self.cmd, tag, datas = struct.unpack_from("!IHH%ds" % (self.packLen - 12), data, 4)
        compress = tag & 7
        if compress == COMPRESS_ZLIB or compress == COMPRESS_DOUBLE_ZLIB:
            datas = zlib.decompress(datas)
        if self.cmd == NET_CMD_RPC:
            self.seq = ((tag >> 8) & 0x0f) << 32 | self.seq
            #self.data = BSON(datas).decode()
            if decodeFormat == "json":
                try:
                    #self.data = json.loads(datas)
                    self.data = json.loads(unicode(datas, "ISO-8859-1"))
                    #self.data = datas
                    print self.data["status"]
                except Exception,e:
                    print e

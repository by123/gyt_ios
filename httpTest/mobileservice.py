# coding=utf-8
import traceback
import hashlib
import logging

logger = logging.getLogger("common")

from net.RPCClient import RPCClient

def generate_password(password):
    _sha1 = hashlib.sha1()
    _sha1.update(password)
    return _sha1.hexdigest()

def call(rpcname, rpcparams):
    try:
        #client = RPCClient(rpcparams["ip"],rpcparams["port"],"json", 60)
        client = RPCClient("192.168.1.111", 64350, "json", 60)
    except:
        rpcResult = {"content":[], "error":{"ErrorID":-101,"ErrorMsg":u'与mobileService连接超时'}}
        logger.error(traceback.format_exc())
        return rpcResult
    if rpcparams.has_key("ip"):
        del rpcparams["ip"]
    if rpcparams.has_key("port"):
        del rpcparams["port"]
    #登录时对参数的处理
    if rpcname=="login":
        rpcparams["strIPAddress"] = rpcparams["request_IP"]
        del rpcparams["request_IP"]
        #调用接口的容错处理
        try:
            rpcparams["strPassword"] = generate_password(rpcparams["strPassword"])
            rpcResult = client.request("login",rpcparams)
        except:
            rpcResult = {"content":[], "error":{"ErrorID":-102,"ErrorMsg":u'与mobileService连接超时'}}
            logger.error(traceback.format_exc())
    #调用其它接口
    else:
        try:
            rpcResult = client.request(rpcname, rpcparams)
        except:
            rpcResult = {"content":[], "error":{"ErrorID":-103,"ErrorMsg":u'与mobileService连接超时'}}
            logger.error(traceback.format_exc())

        # time.sleep(2)
        #print traceback.format_exc()
    return rpcResult

if __name__=="__main__":
    mob_result = call()
import socket

HOST = "127.0.0.1"
PORT = 12050

def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(3.0)
    try:
        sock.connect((HOST, PORT))
        print("✅ 已连上MCC TCP IPC服务端")
    except ConnectionRefusedError:
        print("❌ 连接被拒绝：MCC脚本没启动 / 端口没监听")
        return
    except Exception as e:
        print(f"❌ 连接异常: {e}")
        return
    sock.settimeout(None) # 取消超时，阻塞读写

    while True:
        cmd = input(">>> 输入要发给MCC的命令：")
        if cmd.lower() == "exit":
            break
        # 重点！追加换行 \n，C#那边读到\n才切出一条消息
        payload = (cmd + "\n").encode("utf-8")
        sock.sendall(payload)
        print(f"📤 已发送：{cmd}")
    sock.close()
    print("连接关闭")

if __name__ == "__main__":
    main()

//MCCScript 1.0
/*using MinecraftClient.Mapping;
using MinecraftClient.Scripting;
using System.Data.Common;
using System.Text.Json;*/

MCC.LoadBot(new Bridge());

//MCCScript Extensions

public delegate void Logger(string message);
public static Logger? Log;

/// <summary>
/// Chatbot通信
/// </summary>
internal class Bridge : ChatBot, ChatBotApi
{

    private CmdReceiver? cmdReceiver;
    private CmdExecutor? cmdExecutor;
    private readonly Dictionary<string, Action<Dictionary<string, System.Text.Json.JsonElement>?>> _cmdMappings;

    public Bridge()
    {
        LogToConsole("Bridge 业务已创建");
        _cmdMappings = new()
        {
            {"SendText",                args => cmdExecutor.SendText(args)},
            {"PerformInternalCommand",  args => cmdExecutor.PerformInternalCommand(args)},
            {"DigBlock",                args => cmdExecutor.DigBlock(args)},
            {"SendPlaceBlock",          args => cmdExecutor.SendPlaceBlock(args)},
            {"UseItemInHand",           args => cmdExecutor.UseItemInHand()},
            {"UseItemInLeftHand",       args => cmdExecutor.UseItemInLeftHand()},
            {"Sneak",                   args => cmdExecutor.Sneak(args)},
            {"SendEntityAction",        args => cmdExecutor.SendEntityAction(args)},
            {"InteractEntity",          args => cmdExecutor.InteractEntity(args)},
            {"SendAnimation",           args => cmdExecutor.SendAnimation(args)},
            {"Respawn",                 args => cmdExecutor.Respawn()},
            {"CreativeGive",            args => cmdExecutor.CreativeGive(args)},
            {"CreativeDelete",          args => cmdExecutor.CreativeDelete(args)},
            {"MoveToLocation",          args => cmdExecutor.MoveToLocation(args)},
            {"ClientIsMoving",          args => cmdExecutor.ClientIsMoving()},
            {"LookAtLocation",          args => cmdExecutor.LookAtLocation(args)},
            {"GetLookingBlock",         args => cmdExecutor.GetLookingBlock(args)},
            {"ChangeSlot",              args => cmdExecutor.ChangeSlot(args)},
            {"GetCurrentSlot",          args => cmdExecutor.GetCurrentSlot()},
            {"GetPlayerInventory",      args => cmdExecutor.GetPlayerInventory()},
            {"GetInventories",          args => cmdExecutor.GetInventories()},
            {"WindowAction",            args => cmdExecutor.WindowAction(args)},
            {"GetItemMovingHelper",     args => cmdExecutor.GetItemMovingHelper(args)},
            {"SelectTrade",             args => cmdExecutor.SelectTrade(args)},
            {"CloseInventory",          args => cmdExecutor.CloseInventory(args)},
            {"ClearInventories",        args => cmdExecutor.ClearInventories()},
            {"UpdateSign",              args => cmdExecutor.UpdateSign(args)},
            {"GetCurrentLocation",      args => cmdExecutor.GetCurrentLocation()},
            {"GetYaw",                  args => cmdExecutor.GetYaw()},
            {"GetPitch",                args => cmdExecutor.GetPitch()},
            {"GetWorld",                args => cmdExecutor.GetWorld()},
            {"GetEntities",             args => cmdExecutor.GetEntities()},
            {"GetOnlinePlayers",        args => cmdExecutor.GetOnlinePlayers()},
            {"GetOnlinePlayersWithUUID",args => cmdExecutor.GetOnlinePlayersWithUUID()},
            {"GetServerHost",           args => cmdExecutor.GetServerHost()},
            {"GetServerPort",           args => cmdExecutor.GetServerPort()},
            {"GetUsername",             args => cmdExecutor.GetUsername()},
            {"GetUserUUID",             args => cmdExecutor.GetUserUUID()},
            {"GetPlayerEntityID",       args => cmdExecutor.GetPlayerEntityID()},
            {"GetGamemode",             args => cmdExecutor.GetGamemode()},
            {"GetServerTPS",            args => cmdExecutor.GetServerTPS()},
            {"GetAchievements",         args => cmdExecutor.GetAchievements()},
            {"GetUnlockedAchievements", args => cmdExecutor.GetUnlockedAchievements()},
            {"GetLockedAchievements",   args => cmdExecutor.GetLockedAchievements()},
            {"GetPlayersLatency",       args => cmdExecutor.GetPlayersLatency()},
            {"GetProtocolVersion",      args => cmdExecutor.GetProtocolVersion()},
            {"GetHorizontalFacing",     args => cmdExecutor.GetHorizontalFacing()},
            {"GetMaxChatMessageLength", args => cmdExecutor.GetMaxChatMessageLength()},
            {"GetTerrainEnabled",       args => cmdExecutor.GetTerrainEnabled()},
            {"SetTerrainEnabled",       args => cmdExecutor.SetTerrainEnabled(args)},
            {"GetInventoryEnabled",     args => cmdExecutor.GetInventoryEnabled()},
            {"GetEntityHandlingEnabled",args => cmdExecutor.GetEntityHandlingEnabled()},
            {"RegisterPluginChannel",   args => cmdExecutor.RegisterPluginChannel(args)},
            {"UnregisterPluginChannel", args => cmdExecutor.UnregisterPluginChannel(args)},
            {"SendPluginChannelMessage",args => cmdExecutor.SendPluginChannelMessage(args)},
            {"RegisterChatBotCommand",  args => cmdExecutor.RegisterChatBotCommand(args)},
            {"ReconnectToTheServer",     args => cmdExecutor.ReconnectToTheServer()},
            {"DisconnectAndExit",       args => cmdExecutor.DisconnectAndExit()},
            {"UnloadBot",               args => cmdExecutor.UnloadBot()}
        };
    }

    public override void Initialize()
    {
        LogToConsole("Bridge 业务已启动");
        Log = new Logger(log);
        cmdReceiver = new CmdReceiver();
        cmdExecutor = new CmdExecutor(this);
        cmdReceiver?.Start();
    }

    public override void Update()
    {
        if (cmdReceiver != null)
        {
            var cmdList = cmdReceiver.ReadCmd();
            foreach (var cmd in cmdList)
            {
                string argsText = cmd.args == null ? "(null)": string.Join(
                    " | ", cmd.args.Select(kvp => $"{kvp.Key}={kvp.Value}"));
                Log($"Bridge：发送命令：{cmd.cmd}，参数：{argsText}");
                //操作执行逻辑
                _cmdMappings[cmd.cmd](cmd.args);
            }
        }
    }

    /// <summary>
    /// 重写日志方法
    /// </summary>
    /// <param name="msg"></param>
    private void log(string msg)
    {
        var stack = new System.Diagnostics.StackTrace();
        var frame = stack.GetFrame(1); // <-重点：取调用方，不是自己！
        var m = frame.GetMethod();
        string cls = m.DeclaringType.Name;
        string method = m.Name;
        LogToConsole($"[{cls}.{method}] {msg}");
    }

    public new void SendText(string text, bool sendImmediately = false)
    {
       base.SendText(text, sendImmediately);
    }

    // ChatBot API 公共包装
    public bool PerformInternalCommand(string command, Dictionary<string, object>? localVars = null)
    {
        return base.PerformInternalCommand(command, localVars);
    }

    public bool DigBlock(Location location, Direction direction, bool swingArms = true, bool lookAtBlock = true, double duration = 0, MiningCalculator.MiningOptions? miningOptions = null)
    {
        return base.DigBlock(location, direction, swingArms, lookAtBlock, duration, miningOptions);
    }

    public bool SendPlaceBlock(Location location, Direction blockFace, Hand hand = Hand.MainHand, bool lookAtBlock = false)
    {
        return base.SendPlaceBlock(location, blockFace, hand, lookAtBlock);
    }

    public void UseItemInHand()
    {
        base.UseItemInHand();
    }

    public void UseItemInLeftHand()
    {
        base.UseItemInLeftHand();
    }

    public bool Sneak(bool on)
    {
        return base.Sneak(on);
    }

    public bool SendEntityAction(MinecraftClient.Protocol.EntityActionType entityAction)
    {
        return base.SendEntityAction(entityAction);
    }

    public bool InteractEntity(int EntityID, InteractType type, Hand hand = Hand.MainHand)
    {
        return base.InteractEntity(EntityID, type, hand);
    }

    public bool SendAnimation(Hand hand = Hand.MainHand)
    {
        return base.SendAnimation(hand);
    }

    public bool Respawn()
    {
        return base.Respawn();
    }

    public bool CreativeGive(int slot, ItemType itemType, int count, Dictionary<string, object>? nbt = null)
    {
        return base.CreativeGive(slot, itemType, count, nbt);
    }

    public bool CreativeDelete(int slot)
    {
        return base.CreativeDelete(slot);
    }

    public bool MoveToLocation(Location location, bool allowUnsafe = false, bool allowDirectTeleport = false, int maxOffset = 0, int minOffset = 0, TimeSpan? timeout = null)
    {
        return base.MoveToLocation(location, allowUnsafe, allowDirectTeleport, maxOffset, minOffset, timeout);
    }

    public bool ClientIsMoving()
    {
        return base.ClientIsMoving();
    }

    public void LookAtLocation(Location location)
    {
        base.LookAtLocation(location);
    }

    public void LookAtLocation(float yaw, float pitch)
    {
        base.LookAtLocation(yaw, pitch);
    }

    public Tuple<bool, Location, Block> GetLookingBlock(double maxDistance = 4.5, bool includeFluids = false)
    {
        return base.GetLookingBlock(maxDistance, includeFluids);
    }

    public void ChangeSlot(short slot)
    {
        base.ChangeSlot(slot);
    }

    public byte GetCurrentSlot()
    {
        return base.GetCurrentSlot();
    }

    public Container GetPlayerInventory()
    {
        return base.GetPlayerInventory();
    }

    public Dictionary<int, Container> GetInventories()
    {
        return base.GetInventories();
    }

    public bool WindowAction(int inventoryId, int slot, WindowActionType actionType)
    {
        return base.WindowAction(inventoryId, slot, actionType);
    }

    public ItemMovingHelper GetItemMovingHelper(Container container)
    {
        return base.GetItemMovingHelper(container);
    }

    public bool SelectTrade(int selectedSlot)
    {
        return base.SelectTrade(selectedSlot);
    }

    public bool CloseInventory(int inventoryID)
    {
        return base.CloseInventory(inventoryID);
    }

    public void ClearInventories()
    {
        base.ClearInventories();
    }

    public bool UpdateSign(Location location, string line1, string line2, string line3, string line4)
    {
        return base.UpdateSign(location, line1, line2, line3, line4);
    }

    public Location GetCurrentLocation()
    {
        return base.GetCurrentLocation();
    }

    public float GetYaw()
    {
        return base.GetYaw();
    }

    public float GetPitch()
    {
        return base.GetPitch();
    }

    public World GetWorld()
    {
        return base.GetWorld();
    }

    public Dictionary<int, Entity> GetEntities()
    {
        return base.GetEntities();
    }

    public string[] GetOnlinePlayers()
    {
        return base.GetOnlinePlayers();
    }

    public Dictionary<string, string> GetOnlinePlayersWithUUID()
    {
        return base.GetOnlinePlayersWithUUID();
    }

    public string GetServerHost()
    {
        return base.GetServerHost();
    }

    public int GetServerPort()
    {
        return base.GetServerPort();
    }

    public string GetUsername()
    {
        return base.GetUsername();
    }

    public string GetUserUUID()
    {
        return base.GetUserUUID();
    }

    public int GetPlayerEntityID()
    {
        return base.GetPlayerEntityID();
    }

    public int GetGamemode()
    {
        return base.GetGamemode();
    }

    public double GetServerTPS()
    {
        return base.GetServerTPS();
    }

    public Achievement[] GetAchievements()
    {
        return base.GetAchievements();
    }

    public Achievement[] GetUnlockedAchievements()
    {
        return base.GetUnlockedAchievements();
    }

    public Achievement[] GetLockedAchievements()
    {
        return base.GetLockedAchievements();
    }

    public Dictionary<string, int> GetPlayersLatency()
    {
        return base.GetPlayersLatency();
    }

    public int GetProtocolVersion()
    {
        return base.GetProtocolVersion();
    }

    public Direction GetHorizontalFacing()
    {
        return base.GetHorizontalFacing();
    }

    public int GetMaxChatMessageLength()
    {
        return base.GetMaxChatMessageLength();
    }

    public bool GetTerrainEnabled()
    {
        return base.GetTerrainEnabled();
    }

    public void SetTerrainEnabled(bool enabled)
    {
        base.SetTerrainEnabled(enabled);
    }

    public bool GetInventoryEnabled()
    {
        return base.GetInventoryEnabled();
    }

    public bool GetEntityHandlingEnabled()
    {
        return base.GetEntityHandlingEnabled();
    }

    public void RegisterPluginChannel(string channel)
    {
        base.RegisterPluginChannel(channel);
    }

    public void UnregisterPluginChannel(string channel)
    {
        base.UnregisterPluginChannel(channel);
    }

    public void SendPluginChannelMessage(string channel, byte[] data)
    {
        base.SendPluginChannelMessage(channel, data);
    }

    public void RegisterChatBotCommand(string cmdName, string cmdDesc, string cmdUsage, CommandRunner callback)
    {
        base.RegisterChatBotCommand(cmdName, cmdDesc, cmdUsage, callback);
    }

    public void ReconnectToTheServer()
    {
        base.ReconnectToTheServer();
    }

    public void DisconnectAndExit()
    {
        base.DisconnectAndExit();
    }

    public void UnloadBot()
    {
        base.UnloadBot();
    }

}

/// <summary>
/// ChatBot API 接口，Bridge 实现此接口以公开 ChatBot 的受保护方法
/// </summary>
public interface ChatBotApi
{
    void SendText(string text, bool sendImmediately = false);
    bool PerformInternalCommand(string command, Dictionary<string, object>? localVars = null);
    bool DigBlock(Location location, Direction direction, bool swingArms = true, bool lookAtBlock = true, double duration = 0, MiningCalculator.MiningOptions? miningOptions = null);
    bool SendPlaceBlock(Location location, Direction blockFace, Hand hand = Hand.MainHand, bool lookAtBlock = false);
    void UseItemInHand();
    void UseItemInLeftHand();
    bool Sneak(bool on);
    bool SendEntityAction(MinecraftClient.Protocol.EntityActionType entityAction);
    bool InteractEntity(int EntityID, InteractType type, Hand hand = Hand.MainHand);
    bool SendAnimation(Hand hand = Hand.MainHand);
    bool Respawn();
    bool CreativeGive(int slot, ItemType itemType, int count, Dictionary<string, object>? nbt = null);
    bool CreativeDelete(int slot);
    bool MoveToLocation(Location location, bool allowUnsafe = false, bool allowDirectTeleport = false, int maxOffset = 0, int minOffset = 0, TimeSpan? timeout = null);
    bool ClientIsMoving();
    void LookAtLocation(Location location);
    void LookAtLocation(float yaw, float pitch);
    System.Tuple<bool, Location, Block> GetLookingBlock(double maxDistance = 4.5, bool includeFluids = false);
    void ChangeSlot(short slot);
    byte GetCurrentSlot();
    Container GetPlayerInventory();
    Dictionary<int, Container> GetInventories();
    bool WindowAction(int inventoryId, int slot, WindowActionType actionType);
    ItemMovingHelper GetItemMovingHelper(Container container);
    bool SelectTrade(int selectedSlot);
    bool CloseInventory(int inventoryID);
    void ClearInventories();
    bool UpdateSign(Location location, string line1, string line2, string line3, string line4);
    Location GetCurrentLocation();
    float GetYaw();
    float GetPitch();
    World GetWorld();
    Dictionary<int, Entity> GetEntities();
    string[] GetOnlinePlayers();
    Dictionary<string, string> GetOnlinePlayersWithUUID();
    string GetServerHost();
    int GetServerPort();
    string GetUsername();
    string GetUserUUID();
    int GetPlayerEntityID();
    int GetGamemode();
    double GetServerTPS();
    Achievement[] GetAchievements();
    Achievement[] GetUnlockedAchievements();
    Achievement[] GetLockedAchievements();
    Dictionary<string, int> GetPlayersLatency();
    int GetProtocolVersion();
    Direction GetHorizontalFacing();
    int GetMaxChatMessageLength();
    bool GetTerrainEnabled();
    void SetTerrainEnabled(bool enabled);
    bool GetInventoryEnabled();
    bool GetEntityHandlingEnabled();
    void RegisterPluginChannel(string channel);
    void UnregisterPluginChannel(string channel);
    void SendPluginChannelMessage(string channel, byte[] data);
    void RegisterChatBotCommand(string cmdName, string cmdDesc, string cmdUsage, ChatBot.CommandRunner callback);
    void ReconnectToTheServer();
    void DisconnectAndExit();
    void UnloadBot();
}

/// <summary>
/// 命令接收者
/// </summary>
internal class CmdReceiver
{
    private ServerIPC _serverIPC;


    public CmdReceiver()
    {
        _serverIPC = new ServerIPC();
        Log("命令接收者初始化完成");
    }

    public void Start()
    {
        _serverIPC?.Start();
    }

    public void Stop()
    {
        _serverIPC?.Stop();
    }

    /// <summary>
    /// 读取一次队列内的命令
    /// </summary>
    /// <returns> </returns>
    public List<CmdJson> ReadCmd()
    {
        var cmdJsonList = new List<CmdJson>();
        var cmdList = _serverIPC.GetCmd();
        foreach(string msg in cmdList)
        {
            var cmdJson = ParseCmd(msg);
            if (cmdJson != null)
            {
                cmdJsonList.Add(cmdJson);
            }
        }
        return cmdJsonList;
    }

    /// <summary>
    /// 命令Json格式
    /// </summary>
    public class CmdJson
    {
        public string cmd { get; set; } = "";
        public Dictionary<string, System.Text.Json.JsonElement>? args { get; set; }
    }

    /// <summary>
    /// 解析命令Json文本
    /// </summary>
    public static CmdJson? ParseCmd(string cmdMsg)
    {
        var opt = new System.Text.Json.JsonSerializerOptions
        {
            PropertyNameCaseInsensitive = true,
            WriteIndented = true
        };
        try
        {
            CmdJson? cmdJson = System.Text.Json.JsonSerializer.Deserialize<CmdJson>(cmdMsg, opt);
            if (string.IsNullOrWhiteSpace(cmdJson.cmd))
            {
                Log("命令接收者：命令缺少cmd字段");
                return null;
            }
            return cmdJson;
        }
        catch (System.Text.Json.JsonException)
        {
            Log($"命令接收者：命令格式不正确");
            return null;
        }

    }
}

/// <summary>
/// IPC服务端
/// </summary>
internal class ServerIPC
{
    private System.Net.IPEndPoint _listenIP;
    private Thread? _serverThread;  //Socket等待连接线程
    private Thread? _readerThread;  //Socket连接读取线程

    private System.Collections.Concurrent.ConcurrentQueue<string>? _cmdQueue;
    private bool _running;
    private const int _port = 12050;

    /// <summary>
    /// 初始化IPC服务端
    /// </summary>
    public ServerIPC()
    {
        //socket初始化
        _listenIP = new System.Net.IPEndPoint(System.Net.IPAddress.Loopback, _port);
        _cmdQueue = new System.Collections.Concurrent.ConcurrentQueue<string>();

        //线程初始化
        _running = false;
        _serverThread = new Thread(TcpServerThread);
        _serverThread.IsBackground = true;
        Log("IPC服务端初始化完成");
    }

    /// <summary>
    /// 启动IPC服务端
    /// </summary>
    public void Start()
    {
        if (!_running)
        {
            _serverThread?.Start();
            _running = true;
            Log("IPC服务端已启动：开始监听");
        }
        else
        {
            Log("IPC服务端已启动：正在监听中");
        }

    }

    public void Stop()
    {
        if (_running)
        {
            _running = false;
            Log("IPC服务端已停止：监听已关闭");
        }
        else
        {
            Log("IPC服务端已停止：监听未开启");
        }
    }

    /// <summary>
    /// 从内部并发队列中检索并移除所有可用的命令，按队列顺序返回它们的字符串列表。
    /// </summary>
    /// <remarks>操作为非阻塞，会循环出队直到队列没有可用项；线程安全性依赖于底层并发队列的实现。</remarks>
    /// <returns>包含已检索并从队列移除的命令的字符串列表；队列为空时返回空列表。</returns>
    public List<string> GetCmd()
    {
        var cmdList = new List<string>();
        while (true)
        {
            if (_cmdQueue.TryDequeue(out var cmdMsg))
            {
                cmdList.Add(cmdMsg);
            }
            else
            {
                return cmdList;
            }
        }
    }

    /// <summary>
    /// TCP监听线程
    /// </summary>
    private void TcpServerThread()
    {
        //创建TCP监听套接字
        using var listenerSocket = new System.Net.Sockets.Socket(
            System.Net.Sockets.AddressFamily.InterNetwork,
            System.Net.Sockets.SocketType.Stream,
            System.Net.Sockets.ProtocolType.Tcp);

        try
        {
            listenerSocket.Bind(_listenIP);
            listenerSocket.Listen(1);
            Log($"IPC服务端：正在监听 {_listenIP.Address}:{_listenIP.Port}");
            //TCP监听内容
            while (_running)
            {
                //等待连接
                if (listenerSocket.Poll(100000, System.Net.Sockets.SelectMode.SelectRead))
                {
                    //创建监听线程
                    var clientSocket = listenerSocket.Accept();
                    if (_readerThread != null && _readerThread.IsAlive)
                    {
                        Log("IPC服务端：已有客户端连接，拒绝新的连接");
                        clientSocket.Close();
                        continue;
                    }
                    Log("IPC服务端：检测到客户端连接");
                    _readerThread = new Thread(() => readClientMsg(clientSocket));
                    _readerThread.IsBackground = true;
                    _readerThread.Start();
                }
                //关闭连接
                if (!_running)
                {
                    break;
                }
            }
        }
        catch (System.Net.Sockets.SocketException se)
        {
            Log($"IPC服务端：Socket监听异常：{se.Message}");
        }
        catch (Exception ex)
        {
            Log($"IPC服务端：监听线程异常：{ex.Message}");
        }
        Log("IPC服务端：TCP监听线程退出");

    }

    /// <summary>
    /// 读取数据
    /// </summary>
    /// <param name="clientSocket"></param>
    private void readClientMsg(System.Net.Sockets.Socket clientSocket)
    {
        try
        {
            byte[] buffer = new byte[1024];
            string remain = ""; // 保存未发送完成的消息
            Log("IPC服务端（已连接）：客户端连接成功，开始读取数据");
            while (true)
            {
                int bytesRead = clientSocket.Receive(buffer);
                if (bytesRead == 0 || !_running)
                {
                    //关闭连接
                    break;
                }
                string part = System.Text.Encoding.UTF8.GetString(buffer, 0, bytesRead);
                remain += part;
                var lines = remain.Split('\n');
                remain = lines[lines.Length - 1];
                for (int i = 0; i < lines.Length - 1; i++)
                {
                    var line = lines[i].TrimEnd('\r');
                    if (string.IsNullOrWhiteSpace(line)) continue;
                    _cmdQueue.Enqueue(lines[i]);
                    Log($"IPC服务端（已连接）：收到客户端命令：{line}");

                }
            }
        }
        catch (Exception ex)
        {
            Log($"IPC服务端（已连接）：客户端读取异常：{ex.Message}");
        }
        finally
        {
            clientSocket.Dispose();
            Log("IPC服务端（已连接）：客户端断开连接");
        }
    }
}

/// <summary>
/// 命令执行者
/// </summary>
internal class CmdExecutor
{
    ChatBotApi _chatbotApi;
    public CmdExecutor(ChatBotApi chatbotApi)
    {
        _chatbotApi = chatbotApi;
    }
    // 通用参数解析
    private static T GetArg<T>(Dictionary<string, System.Text.Json.JsonElement>? args, string key)
    {
        if (args == null) return default;
        if (!args.TryGetValue(key, out var el)) return default;
        try
        {
            if (typeof(T) == typeof(string)) return (T)(object)(el.GetString() ?? "");
            if (typeof(T) == typeof(int)) return (T)(object)el.GetInt32();
            if (typeof(T) == typeof(long)) return (T)(object)el.GetInt64();
            if (typeof(T) == typeof(bool)) return (T)(object)el.GetBoolean();
            if (typeof(T) == typeof(double)) return (T)(object)el.GetDouble();
            if (typeof(T) == typeof(float)) return (T)(object)(float)el.GetDouble();

            if (typeof(T) == typeof(Location))
            {
                var loc = el.EnumerateObject().ToDictionary(p => p.Name, p => p.Value);
                double x = 0, y = 0, z = 0;
                if (loc.TryGetValue("x", out var xEl) && xEl.TryGetDouble(out var xv))
                    x = xv;
                if (loc.TryGetValue("y", out var yEl) && yEl.TryGetDouble(out var yv))
                    y = yv;
                if (loc.TryGetValue("z", out var zEl) && zEl.TryGetDouble(out var zv))
                    z = zv;
                return (T)(object)new Location(x, y, z);
            }

            if (typeof(T) == typeof(Direction))
            {
                if (el.ValueKind == System.Text.Json.JsonValueKind.String)
                {
                    var rawStr = el.GetString()?.Trim();
                    if (Enum.TryParse<Direction>(rawStr, ignoreCase: true, out var type))
                    {
                        return (T)(object)type;
                    }
                    return default;
                }
                else if (el.ValueKind == System.Text.Json.JsonValueKind.Number)
                {
                    var rawNum = (Direction)(object)el.GetInt32();
                    if (Enum.IsDefined(typeof(T), rawNum))
                    {
                        return (T)(object)rawNum;
                    }
                    return default;
                }
            }
            else if (typeof(T) == typeof(Hand))
            {
                if (el.ValueKind == System.Text.Json.JsonValueKind.String)
                {
                    var rawStr = el.GetString()?.Trim();
                    if (Enum.TryParse<Hand>(rawStr, ignoreCase: true, out var type))
                    {
                        return (T)(object)type;
                    }
                    return default;
                }
                else if (el.ValueKind == System.Text.Json.JsonValueKind.Number)
                {
                    var rawNum = (Hand)(object)el.GetInt32();
                    if (Enum.IsDefined(typeof(T), rawNum))
                    {
                        return (T)(object)rawNum;
                    }
                    return default;
                }
            }
            else if (typeof(T) == typeof(InteractType))
            {
                if (el.ValueKind == System.Text.Json.JsonValueKind.String)
                {
                    var rawStr = el.GetString()?.Trim();
                    if (Enum.TryParse<InteractType>(rawStr, ignoreCase: true, out var type))
                    {
                        return (T)(object)type;
                    }
                    return default;
                }
                else if (el.ValueKind == System.Text.Json.JsonValueKind.Number)
                {
                    var rawNum = (InteractType)(object)el.GetInt32();
                    if (Enum.IsDefined(typeof(T), rawNum))
                    {
                        return (T)(object)rawNum;
                    }
                    return default;
                }
            }
            else if (typeof(T) == typeof(MinecraftClient.Protocol.EntityActionType))
            {
                if (el.ValueKind == System.Text.Json.JsonValueKind.String)
                {
                    var rawStr = el.GetString()?.Trim();
                    if (Enum.TryParse<MinecraftClient.Protocol.EntityActionType>(rawStr, ignoreCase: true, out var type))
                    {
                        return (T)(object)type;
                    }
                    return default;
                }
                else if (el.ValueKind == System.Text.Json.JsonValueKind.Number)
                {
                    var rawNum = (MinecraftClient.Protocol.EntityActionType)(object)el.GetInt32();
                    if (Enum.IsDefined(typeof(T), rawNum))
                    {
                        return (T)(object)rawNum;
                    }
                    return default;
                }
            }
            else if (typeof(T) == typeof(WindowActionType))
            {
                if (el.ValueKind == System.Text.Json.JsonValueKind.String)
                {
                    var rawStr = el.GetString()?.Trim();
                    if (Enum.TryParse<WindowActionType>(rawStr, ignoreCase: true, out var type))
                    {
                        return (T)(object)type;
                    }
                    return default;
                }
                else if (el.ValueKind == System.Text.Json.JsonValueKind.Number)
                {
                    var rawNum = (WindowActionType)(object)el.GetInt32();
                    if (Enum.IsDefined(typeof(T), rawNum))
                    {
                        return (T)(object)rawNum;
                    }
                    return default;
                }
            }
            else if (typeof(T) == typeof(ItemType))
            {
                if (el.ValueKind == System.Text.Json.JsonValueKind.String)
                {
                    var rawStr = el.GetString()?.Trim();
                    if (Enum.TryParse<ItemType>(rawStr, ignoreCase: true, out var type))
                    {
                        return (T)(object)type;
                    }
                    return default;
                }
                else if (el.ValueKind == System.Text.Json.JsonValueKind.Number)
                {
                    var rawNum = (ItemType)(object)el.GetInt32();
                    if (Enum.IsDefined(typeof(T), rawNum))
                    {
                        return (T)(object)rawNum;
                    }
                    return default;
                }
            }


            if (typeof(T).IsEnum)
            {
                if (el.ValueKind == System.Text.Json.JsonValueKind.Number)
                    return (T)Enum.ToObject(typeof(T), el.GetInt32());
                var s = el.GetString() ?? string.Empty;
                return (T)Enum.Parse(typeof(T), s, true);
            }
            return System.Text.Json.JsonSerializer.Deserialize<T>(el.GetRawText());
        }
        catch
        {
            return default;
        }
    }

    private static byte[] GetByteArrayArg(Dictionary<string, System.Text.Json.JsonElement>? args, string key)
    {
        if (args == null) return Array.Empty<byte>();
        if (!args.TryGetValue(key, out var el)) return Array.Empty<byte>();
        try
        {
            if (el.ValueKind == System.Text.Json.JsonValueKind.String)
            {
                var s = el.GetString() ?? string.Empty;
                return System.Convert.FromBase64String(s);
            }
            if (el.ValueKind == System.Text.Json.JsonValueKind.Array)
            {
                var list = new List<byte>();
                foreach (var item in el.EnumerateArray())
                {
                    if (item.ValueKind == System.Text.Json.JsonValueKind.Number)
                        list.Add((byte)item.GetInt32());
                }
                return list.ToArray();
            }
        }
        catch { }
        return Array.Empty<byte>();
    }

    public void SendText(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var text = GetArg<string>(args, "text") ?? string.Empty;
        var sendImmediately = GetArg<bool>(args, "sendImmediately");
        Log($"正在执行命令 SendText，参数 text = {text}, sendImmediately = {sendImmediately}");
        _chatbotApi.SendText(text, sendImmediately);
    }

    public void PerformInternalCommand(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var command = GetArg<string>(args, "command") ?? string.Empty;
        Dictionary<string, object> localVars = null;
        if (args != null && args.TryGetValue("localVars", out var lv))
        {
            try { localVars = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, object>>(lv.GetRawText()); } catch { localVars = null; }
        }
        Log($"正在执行命令 PerformInternalCommand，参数 command = {command}，localVars = {localVars}");
        _chatbotApi.PerformInternalCommand(command, localVars);
    }

    public void DigBlock(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var loc = GetArg<Location>(args, "location");
        var dir = GetArg<Direction>(args, "direction");
        var swingArms = GetArg<bool>(args, "swingArms");
        var lookAtBlock = GetArg<bool>(args, "lookAtBlock");
        var duration = GetArg<double>(args, "duration");
        var miningOptions = GetArg<MiningCalculator.MiningOptions?>(args, "miningOptions");
        Log($"正在执行命令 DigBlock，参数 location = {loc}, direction = {dir}, swingArms = {swingArms}, lookAtBlock = {lookAtBlock}, duration = {duration}");
        if (loc != null)
            _chatbotApi.DigBlock(loc, dir, swingArms, lookAtBlock, duration, miningOptions);
    }

    public void SendPlaceBlock(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var loc = GetArg<Location>(args, "location");
        var face = GetArg<Direction>(args, "blockFace");
        var hand = GetArg<Hand>(args, "hand");
        var lookAtBlock = GetArg<bool>(args, "lookAtBlock");
        Log($"正在执行命令 SendPlaceBlock，参数 location = {loc}, blockFace = {face}, hand = {hand}, lookAtBlock = {lookAtBlock}");
        if (loc != null)
            _chatbotApi.SendPlaceBlock(loc, face, hand, lookAtBlock);
    }

    public void UseItemInHand() { Log("正在执行命令 UseItemInHand"); _chatbotApi.UseItemInHand(); }
    public void UseItemInLeftHand() { Log("正在执行命令 UseItemInLeftHand"); _chatbotApi.UseItemInLeftHand(); }

    public void Sneak(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var on = GetArg<bool>(args, "on");
        Log($"正在执行命令 Sneak，参数 on = {on}");
        _chatbotApi.Sneak(on);
    }

    public void SendEntityAction(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var action = GetArg<MinecraftClient.Protocol.EntityActionType>(args, "entityAction");
        Log($"正在执行命令 SendEntityAction，参数 entityAction = {action}");
        _chatbotApi.SendEntityAction(action);
    }

    public void InteractEntity(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var id = GetArg<int>(args, "EntityID");
        var type = GetArg<InteractType>(args, "type");
        var hand = GetArg<Hand>(args, "hand");
        Log($"正在执行命令 InteractEntity，参数 EntityID = {id}, type = {type}, hand = {hand}");
        _chatbotApi.InteractEntity(id, type, hand);
    }

    public void SendAnimation(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var hand = GetArg<Hand>(args, "hand");
        Log($"正在执行命令 SendAnimation，参数 hand = {hand}");
        _chatbotApi.SendAnimation(hand);
    }

    public void Respawn() { Log("正在执行命令 Respawn"); _chatbotApi.Respawn(); }

    public void CreativeGive(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var slot = GetArg<int>(args, "slot");
        var itemType = GetArg<ItemType>(args, "itemType");
        var count = GetArg<int>(args, "count");
        Dictionary<string, object>? nbt = null;
        if (args != null && args.TryGetValue("nbt", out var nb))
        {
            try { nbt = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, object>>(nb.GetRawText()); } catch { nbt = null; }
        }
        Log($"正在执行命令 CreativeGive，参数 slot = {slot}, itemType = {itemType}, count = {count}");
        _chatbotApi.CreativeGive(slot, itemType, count, nbt);
    }

    public void CreativeDelete(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var slot = GetArg<int>(args, "slot");
        Log($"正在执行命令 CreativeDelete，参数 slot = {slot}");
        _chatbotApi.CreativeDelete(slot);
    }

    public void MoveToLocation(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var loc = GetArg<Location>(args, "location");
        var allowUnsafe = GetArg<bool>(args, "allowUnsafe");
        var allowDirectTeleport = GetArg<bool>(args, "allowDirectTeleport");
        var maxOffset = GetArg<int>(args, "maxOffset");
        var minOffset = GetArg<int>(args, "minOffset");
        var timeout = GetArg<TimeSpan?>(args, "timeout");
        Log($"正在执行命令 MoveToLocation，参数 location = {loc}, allowUnsafe = {allowUnsafe}, allowDirectTeleport = {allowDirectTeleport}, maxOffset = {maxOffset}, minOffset = {minOffset}");
        if (loc != null)
            _chatbotApi.MoveToLocation(loc, allowUnsafe, allowDirectTeleport, maxOffset, minOffset, timeout);
    }

    public void ClientIsMoving() { Log("正在执行命令 ClientIsMoving"); _chatbotApi.ClientIsMoving(); }

    public void LookAtLocation(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        if (args != null && args.ContainsKey("location"))
        {
            var loc = GetArg<Location>(args, "location");
            if (loc != null) { _chatbotApi.LookAtLocation(loc); return; }
        }
        var yaw = GetArg<float>(args, "yaw");
        var pitch = GetArg<float>(args, "pitch");
        Log($"正在执行命令 LookAtLocation，参数 yaw = {yaw}, pitch = {pitch}");
        _chatbotApi.LookAtLocation(yaw, pitch);
    }

    public void GetLookingBlock(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var maxDistance = GetArg<double>(args, "maxDistance");
        var includeFluids = GetArg<bool>(args, "includeFluids");
        Log($"正在执行命令 GetLookingBlock，参数 maxDistance = {maxDistance}, includeFluids = {includeFluids}");
        _chatbotApi.GetLookingBlock(maxDistance, includeFluids);
    }

    public void ChangeSlot(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var slot = (short)GetArg<int>(args, "slot");
        Log($"正在执行命令 ChangeSlot，参数 slot = {slot}");
        _chatbotApi.ChangeSlot(slot);
    }

    public void GetCurrentSlot() { Log("正在执行命令 GetCurrentSlot"); _chatbotApi.GetCurrentSlot(); }
    public void GetPlayerInventory() { Log("正在执行命令 GetPlayerInventory"); _chatbotApi.GetPlayerInventory(); }
    public void GetInventories() { Log("正在执行命令 GetInventories"); _chatbotApi.GetInventories(); }

    public void WindowAction(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var inventoryId = GetArg<int>(args, "inventoryId");
        var slot = GetArg<int>(args, "slot");
        var actionType = GetArg<WindowActionType>(args, "actionType");
        Log($"正在执行命令 WindowAction，参数 inventoryId = {inventoryId}, slot = {slot}, actionType = {actionType}");
        _chatbotApi.WindowAction(inventoryId, slot, actionType);
    }

    public void GetItemMovingHelper(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var container = GetArg<Container>(args, "container");
        Log($"正在执行命令 GetItemMovingHelper，参数 container = {container}");
        _chatbotApi.GetItemMovingHelper(container);
    }

    public void SelectTrade(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var selectedSlot = GetArg<int>(args, "selectedSlot");
        _chatbotApi.SelectTrade(selectedSlot);
    }

    public void CloseInventory(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var inventoryID = GetArg<int>(args, "inventoryID");
        _chatbotApi.CloseInventory(inventoryID);
    }

    public void ClearInventories() => _chatbotApi.ClearInventories();

    public void UpdateSign(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var loc = GetArg<Location>(args, "location");
        var l1 = GetArg<string>(args, "line1") ?? string.Empty;
        var l2 = GetArg<string>(args, "line2") ?? string.Empty;
        var l3 = GetArg<string>(args, "line3") ?? string.Empty;
        var l4 = GetArg<string>(args, "line4") ?? string.Empty;
        if (loc != null) _chatbotApi.UpdateSign(loc, l1, l2, l3, l4);
    }

    public void GetCurrentLocation() => _chatbotApi.GetCurrentLocation();
    public void GetYaw() => _chatbotApi.GetYaw();
    public void GetPitch() => _chatbotApi.GetPitch();
    public void GetWorld() => _chatbotApi.GetWorld();
    public void GetEntities() => _chatbotApi.GetEntities();
    public void GetOnlinePlayers() => _chatbotApi.GetOnlinePlayers();
    public void GetOnlinePlayersWithUUID() => _chatbotApi.GetOnlinePlayersWithUUID();
    public void GetServerHost() => _chatbotApi.GetServerHost();
    public void GetServerPort() => _chatbotApi.GetServerPort();
    public void GetUsername() => _chatbotApi.GetUsername();
    public void GetUserUUID() { Log("正在执行命令 GetUserUUID"); _chatbotApi.GetUserUUID(); }
    public void GetPlayerEntityID() { Log("正在执行命令 GetPlayerEntityID"); _chatbotApi.GetPlayerEntityID(); }
    public void GetGamemode() { Log("正在执行命令 GetGamemode"); _chatbotApi.GetGamemode(); }
    public void GetServerTPS() { Log("正在执行命令 GetServerTPS"); _chatbotApi.GetServerTPS(); }
    public void GetAchievements() { Log("正在执行命令 GetAchievements"); _chatbotApi.GetAchievements(); }
    public void GetUnlockedAchievements() { Log("正在执行命令 GetUnlockedAchievements"); _chatbotApi.GetUnlockedAchievements(); }
    public void GetLockedAchievements() { Log("正在执行命令 GetLockedAchievements"); _chatbotApi.GetLockedAchievements(); }
    public void GetPlayersLatency() { Log("正在执行命令 GetPlayersLatency"); _chatbotApi.GetPlayersLatency(); }
    public void GetProtocolVersion() { Log("正在执行命令 GetProtocolVersion"); _chatbotApi.GetProtocolVersion(); }
    public void GetHorizontalFacing() { Log("正在执行命令 GetHorizontalFacing"); _chatbotApi.GetHorizontalFacing(); }
    public void GetMaxChatMessageLength() { Log("正在执行命令 GetMaxChatMessageLength"); _chatbotApi.GetMaxChatMessageLength(); }
    public void GetTerrainEnabled() { Log("正在执行命令 GetTerrainEnabled"); _chatbotApi.GetTerrainEnabled(); }

    public void SetTerrainEnabled(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var enabled = GetArg<bool>(args, "enabled");
        Log($"正在执行命令 SetTerrainEnabled，参数 enabled = {enabled}");
        _chatbotApi.SetTerrainEnabled(enabled);
    }

    public void GetInventoryEnabled() { Log("正在执行命令 GetInventoryEnabled"); _chatbotApi.GetInventoryEnabled(); }
    public void GetEntityHandlingEnabled() { Log("正在执行命令 GetEntityHandlingEnabled"); _chatbotApi.GetEntityHandlingEnabled(); }

    public void RegisterPluginChannel(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var channel = GetArg<string>(args, "channel") ?? string.Empty;
        Log($"正在执行命令 RegisterPluginChannel，参数 channel = {channel}");
        _chatbotApi.RegisterPluginChannel(channel);
    }

    public void UnregisterPluginChannel(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        var channel = GetArg<string>(args, "channel") ?? string.Empty;
        Log($"正在执行命令 UnregisterPluginChannel，参数 channel = {channel}");
        _chatbotApi.UnregisterPluginChannel(channel);
    }

    public void SendPluginChannelMessage(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        string channel = GetArg<string>(args, "channel") ?? string.Empty;
        var data = GetByteArrayArg(args, "data");
        Log($"正在执行命令 SendPluginChannelMessage，参数 channel = {channel}, dataLength = {data?.Length}");
        _chatbotApi.SendPluginChannelMessage(channel, data);
    }

    public void RegisterChatBotCommand(Dictionary<string, System.Text.Json.JsonElement>? args)
    {
        string command = GetArg<string>(args, "command") ?? string.Empty;
        string cmdName = GetArg<string>(args, "cmdName") ?? string.Empty;
        string cmdDesc = GetArg<string>(args, "cmdDesc") ?? string.Empty;
        string cmdUsage = GetArg<string>(args, "cmdUsage") ?? string.Empty;
        ChatBot.CommandRunner callback = GetArg<ChatBot.CommandRunner>(args, "callback");
        Log($"正在执行命令 RegisterChatBotCommand，参数 command = {command}, cmdName = {cmdName}");
        _chatbotApi.RegisterChatBotCommand(command, cmdName, cmdDesc, callback);
    }

    public void ReconnectToTheServer() { Log("正在执行命令 ReconnectToTheServer"); _chatbotApi.ReconnectToTheServer(); }
    public void DisconnectAndExit() { Log("正在执行命令 DisconnectAndExit"); _chatbotApi.DisconnectAndExit(); }
    public void UnloadBot() { Log("正在执行命令 UnloadBot"); _chatbotApi.UnloadBot(); }
}


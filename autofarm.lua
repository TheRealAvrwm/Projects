while true do
    local _place = game.PlaceId
    local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"

    function ListServers(cursor)
        local Raw = game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
        return Http:JSONDecode(Raw)
    end

    local Server, Next
    repeat
        local Servers = ListServers(Next)
        Server = Servers.data[1]
        Next = Servers.nextPageCursor
    until Server

    TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)

    wait(10)
end

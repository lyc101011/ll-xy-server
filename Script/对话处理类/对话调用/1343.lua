-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-12-11 04:32:22

local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
-----------------------------修业所
__NPCdh111[1343]=function (ID,编号,页数,已经在任务中,数字id)
    local wb = {}
    local xx = {}
    if 编号 == 1 then
        wb[1] = "少侠请选择需要的服务"
        xx = {"炼化修业点","修业系统","我要挑战四圣兽","我就随便看看"}
        return {"自在天魔法杖","星罗杖",wb[取随机数(1,#wb)],xx}
    end
    return
end

__NPCdh222[1343]=function (id,数字id,序号,内容)
    local 事件=内容[1]
    local 名称=内容[3]
        if 事件=="炼化修业点" then
            发送数据(id,440006,{认证码==1,类型=="修炼"})
        elseif 事件=="修业系统" then
            发送数据(id,440006.1)
        elseif 事件=="我要挑战四圣兽" then
            添加最后对话(数字id,"#G少侠。。。召唤四圣兽可不是那么容易的，少侠可得付出#R500w两#W白银的代价！\n#G召唤出的圣兽全服玩家均可击杀，你愿意为全服召唤圣兽吗？",{"召唤圣兽青龙","召唤圣兽白虎","召唤圣兽朱雀","召唤圣兽玄武","我再逛逛"})
        elseif 事件 =="召唤圣兽青龙" or 事件 =="召唤圣兽白虎" or 事件 =="召唤圣兽朱雀" or 事件 =="召唤圣兽玄武" then
                if 玩家数据[数字id].角色:扣除银子(5000000,0,0,"召唤圣兽",1) then
                    if 事件 =="召唤圣兽青龙" then
                            自写活动:圣兽青龙()
                    广播消息({内容=format("#S(召唤圣兽)#G玩家：#Y/%s#G大公无私，竟花费了500w银两，为全服玩家#R/%s！",玩家数据[数字id].角色.名称,事件),频道="xt"})
                    发送公告("#Y玩家：#S"..玩家数据[数字id].角色.名称.."#Y大公无私，竟花费#R500w#Y银两，为全服玩家"..事件.."！")
                    elseif  事件 =="召唤圣兽白虎" then
                            自写活动:圣兽白虎()
                    广播消息({内容=format("#S(召唤圣兽)#G玩家：#Y/%s#G大公无私，竟花费了500w银两，为全服玩家#R/%s！",玩家数据[数字id].角色.名称,事件),频道="xt"})
                    发送公告("#Y玩家：#S"..玩家数据[数字id].角色.名称.."#Y大公无私，竟花费#R500w#Y银两，为全服玩家"..事件.."！")
                    elseif  事件 =="召唤圣兽朱雀" then
                            自写活动:圣兽朱雀()
                    广播消息({内容=format("#S(召唤圣兽)#G玩家：#Y/%s#G大公无私，竟花费了500w银两，为全服玩家#R/%s！",玩家数据[数字id].角色.名称,事件),频道="xt"})
                    发送公告("#Y玩家：#S"..玩家数据[数字id].角色.名称.."#Y大公无私，竟花费#R500w#Y银两，为全服玩家"..事件.."！")
                    elseif  事件 =="召唤圣兽玄武" then
                            自写活动:圣兽玄武()
                    广播消息({内容=format("#S(召唤圣兽)#G玩家：#Y/%s#G大公无私，竟花费了500w银两，为全服玩家#R/%s！",玩家数据[数字id].角色.名称,事件),频道="xt"})
                    发送公告("#Y玩家：#S"..玩家数据[数字id].角色.名称.."#Y大公无私，竟花费#R500w#Y银两，为全服玩家"..事件.."！")
                    end
                else
                    常规提示(数字id,"由于你的银两不足，召唤失败")
                    return
                end


        end
end
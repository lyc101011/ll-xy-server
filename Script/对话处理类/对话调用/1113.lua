local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1113]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "我的事情太多了，忙不过来，请优先选择一件你要做的事情吧。"
	elseif 编号 == 2 then
		wb[1] = "仙丹能治百病，却治不了贪婪的人心。"
		wb[2] = "当年有志学长生，今日方知道行精。运动乾坤颠倒理，转移日月互为明。"
		local xx = {}
		return {"男人_道士","炼丹道士",wb[sj(1,#wb)],xx}
	elseif 编号 == 3 then
		wb[1] = "我这里可以花费银子快速补回法宝灵气，1级法宝收费200万银子、2级法宝收费350万银子、3级法宝收费600万银子。你需要使用这项功能吗？"
		local xx = {"请帮我法宝补充灵气","法宝锻造","兑换法宝","这么贵？"}--,"兑换灵宝","兑换通用灵宝"
		return {"男人_道童","金童子",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1113]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="金童子" then
		if 事件=="请帮我法宝补充灵气" then
		  	玩家数据[数字id].给予数据={类型=1,id=0,事件="法宝补充灵气"}
		  	发送数据(id,3530,{道具=玩家数据[数字id].道具:索要法宝2(数字id,0),名称="金童子",类型="法宝",等级="无"})
		elseif 事件=="法宝锻造" then
			 玩家数据[数字id].给予数据={类型=1,id=0,事件="法宝锻造"}
			发送数据(id,300,{"法宝锻造"})
		elseif 事件=="兑换法宝" then
			玩家数据[数字id].商品列表=商店处理类.商品列表[50]
			发送数据(id,9,{商品=商店处理类.商品列表[50],银子=玩家数据[数字id].角色.门贡,类型="门贡法宝"})
		elseif 事件=="兑换灵宝" then
			-- 玩家数据[数字id].商品列表=商店处理类.商品列表[48]
			-- 发送数据(id,9,{商品=商店处理类.商品列表[48],银子=玩家数据[数字id].角色.门贡,类型="门贡灵宝"})
		elseif 事件=="兑换通用灵宝" then
			-- 玩家数据[数字id].商品列表=商店处理类.商品列表[49]
			-- 发送数据(id,9,{商品=商店处理类.商品列表[49],银子=玩家数据[数字id].角色.门贡,类型="门贡灵宝"})
		end
	elseif 名称=="太上老君" then
	end
end
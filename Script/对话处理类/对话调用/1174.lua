-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-11 00:07:11
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:37:48
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:17
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1174]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "我可以送你去长寿郊外，你要去吗？"
		local xx = {"是的我要去","我还要逛逛"}
		return {"兔子怪","地遁鬼",wb[1],xx}
	elseif 编号 == 2 then
		wb[1] = "我可以送你去女娲神迹，你要去吗？"
		local xx = {}
		-- if 玩家数据[数字id].角色.历劫.女娲 then
			xx = {"是的我要去","我还要逛逛"}
		-- end
		return {"净瓶女娲","女娲神迹传送人",wb[1],xx}
	elseif 编号 == 3 then
		wb[1] = "北俱芦洲的风雪千年不变，这块冰封的大路上也有无数的宝藏。"
		wb[2] = "行走江湖这么久，哪里才是我的栖身之所呢……"
		wb[3] = "少侠你打南边来，可曾见到翻天怪的行踪？"
		wb[4] = "为什么，为什么我总是感觉冥冥之中有几个声音在耳边，而那声音又那么像我自己。"
		return {"星灵仙子","青琉璃",wb[sj(1,#wb)],xx}
	 --[[ elseif 编号 == 4 then
			wb[1] = "我这里的商品琳琅满目应有尽有，年轻人想要什么尽管开口。"
			wb[2] = "作买卖要讲究变通，眼明手快，商场如战场，时机不等人啊。"
			return {"仓库保管员","江湖奸商",wb[sj(1,#wb)],xx} --]]
	elseif 编号 == 5 then
		wb[1] = "这里的龙窟凤巢是升级的好地方，但是没有些本事可千万不要去冒险，最好找些同伴一起去。"
		wb[2] = "这里到处是冰天雪地，没有人家的。"
		wb[3] = "若是没有真本事，还是不要去惹恼这里的翻天怪。"
		wb[4] = "冰是睡着的冰，这厚厚冰层之下的水，连接着父王的水晶宫。"
		local 任务id
		if 玩家数据[数字id].角色:取任务(301)~=0 or 玩家数据[数字id].角色:取任务(302)~=0 then --青龙玄武
			wb={"你找我有什么事情吗？"}
			xx={}
			任务id= 玩家数据[数字id].角色:取任务(301)
			if 任务id~=0 and 任务数据[任务id].人物=="龙女妹妹" then
				xx[#xx+1] = "青龙任务"
			end
			任务id= 玩家数据[数字id].角色:取任务(302)
			if 任务id~=0 and 任务数据[任务id].人物=="龙女妹妹" then
				xx[#xx+1] = "玄武任务"
			end
			xx[#xx+1] = "没什么，我只是看看"
			return {"小龙女","龙女妹妹",wb[1],xx}
		end
		return {"小龙女","龙女妹妹",wb[sj(1,#wb)],xx}
	elseif 编号 == 4 then
		wb[1] = "我是专门治疗和调训召唤兽的医生，10级以下免费治疗驯养，选择驯养或治疗之前请注意：我每次都是把你身上携带的所有召唤兽进行统一治疗和驯养"
		local xx = {"我的召唤兽受伤了，请帮我救治一下吧","我的召唤兽忠诚度降低了，请帮我驯养一下吧","我要同时补满召唤兽的气血、魔法和忠诚","我要提升召唤兽忠诚","我只是看看","我要重置召唤兽属性点"}
		return{"男人_巫医","超级巫医",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 6 then
		wb[1] = "北俱一年四季都被冰雪覆盖。"
		wb[2] = "这里终年冰封，寸草不生。"
		wb[3] = "方圆几百里内没有人家，倒是常有不少凶猛的野兽出没。"
		wb[4] = "北俱龙窟凤巢，是江湖探险者的好去处。"
		return {"山贼","莽汉",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1174 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="地遁鬼" then
		if 事件=="是的我要去" then
		  地图处理类:跳转地图(数字id,1091,73,103)
		end
	elseif 名称=="女娲神迹传送人" then
		if 事件=="是的我要去" then
		  -- if 玩家数据[数字id].角色.历劫.女娲 then
			地图处理类:跳转地图(数字id,1201,47,105)
		 --  else
			-- 发送数据(玩家数据[数字id].连接id,1501,{名称="女娲神迹传送人",模型="净瓶女娲",对话="你尚未完成女娲神迹剧情，我无法将你传送至女娲神迹。"})
		 --  end
		end
	end

end
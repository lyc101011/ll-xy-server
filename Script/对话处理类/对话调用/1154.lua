-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 17:46:24
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

__NPCdh111[1154]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "大家往来神木之上，切记这里的一草一木，均有神灵在，不可以随便踩到花花草草哦！"
		wb[2] = "我神木林一派擅长操控自然之灵，天地万物均可化为己用，但谨记必须对神灵心存敬畏，方能运用自如。"
		wb[3] = "神木林千百年幽闭在武神坛之上，现在打开门户广纳门派，来来往往热闹了许多，突然有点不习惯#17"
		wb[4] = "我违背先祖遗训，打开了神木林的大门，让我族法传承出去，这究竟是对是错，全看徒儿你们是否真能为三界安危尽一份力了……"
		local xx = {"交谈","给予","乾元丹学习","师门任务","学习技能","我想切换流派"}
		if 玩家数据[数字id].角色.门派 == "无" or 玩家数据[数字id].角色.门派 == "无门派" then
			xx={"我还想去其他门派看看……","请收我为徒"}
	    elseif 玩家数据[数字id].角色.门派~="神木林" then
		    xx={}
		end
		if 玩家数据[数字id].角色:取任务(1163)~=0 and 任务数据[玩家数据[数字id].角色:取任务(1163)].分类==6 and 任务数据[玩家数据[数字id].角色:取任务(1163)].SX.地图编号==ID then
			xx = {"文韵墨香","我点错了"}
			if 玩家数据[数字id].角色.门派=="神木林" then
			    xx = {"文韵墨香","我要做其他事情","我点错了"}
			end
		end
		if 玩家数据[数字id].角色:取任务(300)~=0 then --优先级最高
			local 任务id= 玩家数据[数字id].角色:取任务(300)
			if 任务数据[任务id].人物=="巫奎虎" then
				wb={}
				xx={}
				wb[1] = "原来是你给我送东西来了。怎么改行当镖师了？"
				押镖:完成押镖任务(任务id,数字id,任务数据[任务id].人物地图)
			else
				wb={}
				xx={}
			    wb[1] = "少侠你的镖是不是运送错了地方呢，再仔细看看任务提示！"
			end
		end
		return {"巫奎虎","巫奎虎",wb[sj(1,#wb)],xx,"门派师傅"}
	end
	return
end

__NPCdh222[1154 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="巫奎虎" then
        local 门派类型="神木林"
        if 事件=="请收我为徒" then
          玩家数据[数字id].角色:加入门派(数字id,门派类型)
        elseif 事件=="交谈" then
          --玩家数据[数字id].角色:门派交谈(数字id,门派类型)
        elseif 事件=="师门任务" then
          玩家数据[数字id].角色:门派任务(数字id,门派类型)
        elseif 事件=="学习技能" then
          --local 临时数据=玩家数据[数字id].角色:取总数据()
          发送数据(id,31,玩家数据[数字id].角色:取总数据1())
          发送数据(id,32)
        elseif 事件=="文韵墨香" then
			if 玩家数据[数字id].队伍 == 0 then
				常规提示(数字id,"请组队后再来吧！")
				return
			end
			玩家数据[数字id].给予数据={类型=1,id=0,事件="文墨门派送信"}
			发送数据(id,3530,{道具=玩家数据[数字id].道具:索要道具1(数字id),名称="巫奎虎",类型="NPC",等级="无"})
		elseif 事件=="我要做其他事情" then
		    添加最后对话(数字id,"大家往来神木之上，切记这里的一草一木，均有神灵在，不可以随便踩到花花草草哦！",{"交谈","给予","乾元丹学习","师门任务","学习技能","我想切换流派"})
        end
    end
end
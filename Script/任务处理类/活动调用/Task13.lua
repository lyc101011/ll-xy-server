-- @Author: baidwwy
-- @Date:   2024-12-14 19:53:28
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-09 23:11:13
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-02-01 22:25:39
-- @最后修改来自: baidwwy
-- @Last Modified time: 2022-12-24 09:52:25
function 设置任务13(id)
	 if 玩家数据[id].角色:取任务(501)~=0 then 添加最后对话(id,"人物修炼和召唤兽修炼不能同时进行")return end
		if 玩家数据[id].角色.等级<60 then
			添加最后对话(id,"只有等级达到60级的玩家才可以领取本任务。")
			return
		elseif 玩家数据[id].角色.银子<500000 then
			添加最后对话(id,"你没有那么多的银子。")
			return
		end
		玩家数据[id].角色:扣除银子(50000,0,0,"领取宠物修炼任务",1)
		local 任务id=id.."_13_"..os.time()
		local 结束时间=99999999
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=结束时间,
			玩家id=id,
			队伍组={},
			名称=1,
			模型=1,
			地图编号=1001,
			地图名称=1,
			积分=0,
			次数=1,
			类型=13
		}
		玩家数据[id].角色:添加任务(任务id)
		GetUpMOB13(id,任务id)
end

function GetUpMOB13(id,任务id)
	local 类型=取随机数(1,15)
	if 类型<=11 then
		类型=11
	end
	local 序列=取随机数(1,#Q_随机人物)
	local 地图=Q_随机人物[序列].地图
	local 名称=Q_随机人物[序列].人物[取随机数(1,#Q_随机人物[序列].人物)]
	--地图=1111
	--名称="马真人"
	任务数据[任务id].地图编号=地图
	任务数据[任务id].地图名称=取地图名称(地图)
	任务数据[任务id].名称=名称
	任务数据[任务id].分类=类型
	任务数据[任务id].传说=nil
	if 类型==11 then
	 添加最后对话(id,format("前些日子%s的%s帮了我不少忙，请你前去替我感谢他吧。",任务数据[任务id].地图名称,任务数据[任务id].名称))
	elseif 类型==12 then --索要环装
		local 临时等级=取随机数(6,8)
		任务数据[任务id].等级=临时等级
		临时限制=临时等级
		local 物品名称=装备处理类.打造物品[取随机数(1,23)][临时限制+1]
		if type(物品名称)=="table" then
			物品名称=物品名称[取随机数(1,#物品名称)]
		end
		任务数据[任务id].物品= 物品名称
		if 任务数据[任务id].物品==nil then
		 任务数据[任务id].物品="追星踏月"
		 任务数据[任务id].等级=6
		end
	 添加最后对话(id,format("听闻%s的%s正在四处搜寻#Y%s#W，请你帮他寻找一个吧。",任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].物品))
	elseif 类型==13 then
	 local  物品表={"烤肉","醉生梦死","蛇胆酒","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","烤鸭","虎骨酒"}
	 任务数据[任务id].物品=物品表[取随机数(1,#物品表)]
	 添加最后对话(id,format("听闻%s的%s正在四处搜寻#Y%s#W，请你帮他寻找一个吧。",任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].物品))
	elseif 类型==14 then
	 local  物品表={"金香玉","小还丹","千年保心丹","风水混元丹","定神香","蛇蝎美人","九转回魂丹","佛光舍利子","十香返生丸","五龙丹"}
	 任务数据[任务id].物品=物品表[取随机数(1,#物品表)]
	 添加最后对话(id,format("听闻%s的%s正在四处搜寻#Y%s#W，请你帮他寻找一个吧。",任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].物品))
	elseif 类型==15 then
	 local bb表={"巨蛙","野猪","强盗","野鬼","狼","僵尸","马面","牛头","古代瑞兽","天兵","树怪","赌徒","狐狸精","花妖","黑熊","老虎","牛妖","骷髅怪","羊头怪","蛤蟆精","兔子怪"}
	 任务数据[任务id].bb=bb表[取随机数(1,#bb表)]
	 添加最后对话(id,format("%s的%s沉迷于炼妖，现在他正缺少#Y%s#W，还请你想法子给他弄一只吧。",任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].bb))
	end
	玩家数据[id].角色:刷新任务跟踪()
end

function 完成任务_13(id,任务id)
	if 任务数据[任务id]==nil then return  end
	local 次数=任务数据[任务id].次数
	local 积分=4
	if 次数<=5 then
		积分=5
	elseif 次数<=20 then
		积分=6
	elseif 次数<=30 then
		积分=7
	elseif 次数<=40 then
		积分=8
	elseif 次数<=50 then
		积分=9
	elseif 次数<=60 then
		积分=10
	elseif 次数<=70 then
		积分=11
	elseif 次数<=80 then
		积分=12
	elseif 次数<=90 then
		积分=13
	else
		积分=14
	end
	任务数据[任务id].次数=任务数据[任务id].次数+1
	任务数据[任务id].积分=任务数据[任务id].积分+1
	玩家数据[id].角色:添加bb修炼经验(id,积分*3)
	-- 发送数据(玩家数据[id].连接id,38,{内容="你获得了"..积分.."点召唤兽修炼经验"})
	if 玩家数据[id].队伍 ~= 0 then
		for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			local id1 = 队伍数据[玩家数据[id].队伍].成员数据[n]
			if id1 ~= id then
				local 积分1 = qz(积分)*10
				玩家数据[id1].角色:添加bb修炼经验(id1,积分1)
				-- 发送数据(玩家数据[id1].连接id,38,{内容="你获得了"..积分1.."点召唤兽修炼经验"})
			end
		end
	end
	-- 发送数据(玩家数据[id].连接id,38,{内容="你完成了本环的任务，任务达到100后将自动获得书铁奖励。"})

	if 任务数据[任务id].次数>=100 then
		 local 奖励数据=玩家数据[id].道具:给予书铁(id,{9,13})
		广播消息({内容=format("#S(宠物修炼)#R/%s#Y在宠物修炼任务中的积分达到了100，因此获得了马真人奖励的#G/%s#Y",玩家数据[id].角色.名称,奖励数据[1]),频道="xt"})
		玩家数据[id].角色:取消任务(任务id)
		常规提示(id,"#Y恭喜你完成了全部的召唤兽修炼任务")
		任务数据[任务id].次数=0
		任务数据[任务id].积分=0
		任务数据[任务id]=nil
	else
		GetUpMOB13(id,任务id)
	end
end

function 任务说明13(玩家id,任务id)
	local 说明 = {}
	if 任务数据[任务id].分类==11  then
		说明={"召唤兽修炼任务",format("#L找到%s的%s,当前第%s环，任务积分%s分。",任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].次数,任务数据[任务id].积分),"可获得召唤兽修炼经验，在完成第100次任务时将获得随机书铁"}
	elseif 任务数据[任务id].分类==12 or 任务数据[任务id].分类==13 or 任务数据[任务id].分类==14 then
		说明={"召唤兽修炼任务",format("#L将#Y%s#L交给%s的%s,当前第%s环，任务积分%s分。",任务数据[任务id].物品,任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].次数,任务数据[任务id].积分),"可获得召唤兽修炼经验，在完成第100次任务时将获得随机书铁。本任务所需的物品可以在自身等级对应的场景暗雷战斗中几率获得。"}
	elseif 任务数据[任务id].分类==15 then
		说明={"召唤兽修炼任务",format("#L将#Y%s#L交给%s的%s,当前第%s环，任务积分%s分。",任务数据[任务id].bb,任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].次数,任务数据[任务id].积分),"可获得召唤兽修炼经验，在完成第100次任务时将获得随机书铁。本任务所需的变异召唤兽可以在自身等级对应的场景暗雷战斗中几率遇见。"}
	end
	return 说明
end
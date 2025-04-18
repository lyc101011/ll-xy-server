-- @Author: baidwwy
-- @Date:   2024-03-05 15:36:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-04-03 22:01:09

function 设置任务1(id,变化之术,数据,指定)
	local 任务id=id.."_1_"..os.time()
	local 结束时间=15*(1+变化之术)*60
	if 指定 then
	    结束时间=指定
	end
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=结束时间,
		玩家id=id,
		队伍组={},
		数据=数据,
		类型=1
	}
	玩家数据[id].角色:添加任务(任务id)
	发送数据(玩家数据[id].连接id,39)
end

function 设置任务1a(id,变化之术,数据)
	local 任务id=id.."_1_"..os.time()
	local 结束时间=7200
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=结束时间,
		玩家id=id,
		队伍组={},
		数据=数据,
		类型=1
	}
	玩家数据[id].角色:添加任务(任务id)
	发送数据(玩家数据[id].连接id,39)
end

function rwgx1(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
		if 玩家数据[任务数据[任务id].玩家id]~=nil then
			玩家数据[任务数据[任务id].玩家id].角色:取消任务(任务id)
			发送数据(玩家数据[任务数据[任务id].玩家id].连接id,39)
			常规提示(任务数据[任务id].玩家id,"你的变身时间到期了！")
			玩家数据[任务数据[任务id].玩家id].角色.变身数据=nil
			发送数据(玩家数据[任务数据[任务id].玩家id].连接id,37,"1")
			发送数据(玩家数据[任务数据[任务id].玩家id].连接id,37,玩家数据[任务数据[任务id].玩家id].角色.变身数据)
			地图处理类:更改模型(任务数据[任务id].玩家id,玩家数据[任务数据[任务id].玩家id].角色.变身数据,1)
		end
		任务数据[任务id]=nil
	end
end

function 任务说明1(玩家id,任务id)
	local 说明 = {}
		说明={"变身卡","#L你的变身效果还可持续#R/"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#L/分钟。",nil,取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))}
	return 说明
end
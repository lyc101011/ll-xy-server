-- @Author: baidwwy
-- @Date:   2024-03-05 15:36:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-29 04:08:46
local 降妖伏魔 = class()

function 降妖伏魔:初始化()
	self.活动开关=false
	self.奖池={}
	self.活动时间=QJHDSJ["降妖伏魔"]
	self:加载奖池()
end

function 降妖伏魔:添加降妖伏魔任务(id)
	if 取队伍任务(玩家数据[id].队伍,1132) or 取队伍任务(玩家数据[id].队伍,1133) or 取队伍任务(玩家数据[id].队伍,1134)
		or 取队伍任务(玩家数据[id].队伍,1135) or 取队伍任务(玩家数据[id].队伍,1138) or 取队伍任务(玩家数据[id].队伍,1139)
			or 取队伍任务(玩家数据[id].队伍,1140)  or 取队伍任务(玩家数据[id].队伍,1141)  or 取队伍任务(玩家数据[id].队伍,1142) then
		常规提示(id,"#Y/队伍中已有队员领取过此类任务了")
		return
	end
	local 类型=取随机数(1,4)
	if 类型==2 then
		类型=取随机数(3,4) --很烦 梦魇魔有问题
	end
	if 类型==1 then --巧智魔
		self:巧智魔1(id)
	elseif 类型==2 then --梦魇魔
		self:梦魇魔1(id)
	elseif 类型==3 then --怯弱妖
		self:怯弱妖1(id)
	elseif 类型==4 then --迷幻妖
		if 取随机数(1,101)<=50 then
		self:迷幻妖(id)
		else
			玩家数据[id].道具:给予道具(id,"逐妖蛊虫",1)
			常规提示(id,"#Y你的得到了#G逐妖蛊虫")
		end
	end
end

function 降妖伏魔:活动定时器()
	if self.活动开关 then
		if self.开启Time-os.time()<0 then
			self:关闭活动()
		else
			if 服务端参数.秒+0==0 and (服务端参数.分钟+0==0 or 服务端参数.分钟+0==10 or 服务端参数.分钟+0==20 or 服务端参数.分钟+0==30 or 服务端参数.分钟+0==40 or 服务端参数.分钟+0==50) then
				self:刷出怪物()
			end
		end
	else
		if self.活动时间.日期=="每天" then
			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
				self:开启活动()
			end
		else
			local zhouji=tonumber(os.date("%w", os.time()))
			if zhouji==self.活动时间.日期 then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周135" and (zhouji==1 or zhouji==3 or zhouji==5) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周246" and (zhouji==2 or zhouji==4 or zhouji==6) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			end
		end
	end
end

function 降妖伏魔:开启活动()
	发送公告("#G(降妖伏魔)#P已经开启，大家可以到长寿郊外的鬼谷道士或西凉女国的鬼谷道士分身领取降妖伏魔任务了！")
	广播消息({内容=format("#G(降妖伏魔)#P已经开启，大家可以到长寿郊外的鬼谷道士或西凉女国的鬼谷道士分身领取降妖伏魔任务了！"),频道="hd"})
	self.开启Time=os.time()+5400
	self.活动开关=true
end

function 降妖伏魔:刷出怪物()
	self:饿鬼()
	self:酒鬼()
	self:冥想幽鬼()
	self:勾魂幽灵()
	self:机械游魂()
	self:夜叉()
	self:千年魔灵()
	self:万年魔灵()
end

function 降妖伏魔:关闭活动(任务id) --这个也行吧
	self.活动开关=false
	self.开启Time=nil
	发送公告("#G(降妖伏魔)#P活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。大家可以去鬼谷道士处参与铃铛抽奖了！")
	广播消息({内容=format("#G(降妖伏魔)#P活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。大家可以去鬼谷道士处参与铃铛抽奖了！"),频道="hd"})
end

function 降妖伏魔:任务说明(玩家id,任务id)
	if not self.活动开关 then
		return {"降妖伏魔",format("活动已经结束。")}
	end
	local 类型 = 任务数据[任务id].类型
	local 说明 = {}
	if 类型==1132 then --巧智魔1
	  说明={"降妖伏魔",format("去%s#R(%s,%s)#W找#R巧智魔#W。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	elseif 类型==1133 then --巧智魔2
	  说明={"降妖伏魔",format("去%s#R(%s,%s)#W找#R巧智魔#W。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	elseif 类型==1134 then --梦魇魔
	  说明={"降妖伏魔",format("去%s#R(%s,%s)#W找#R梦魇魔#W。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	elseif 类型==1135 then --给予招魂帖
	  说明={"降妖伏魔",format("去%s#R(%s,%s)#W处使用“招魂帖”，等待被诱惑的妖魔上钩并降伏它。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	elseif 类型==1138 then --假怯弱妖
	  说明={"降妖伏魔",format("去%s#R(%s,%s)#W找#R怯弱妖#W。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	elseif 类型==1139 then --真怯弱妖
	  说明={"降妖伏魔",format("去%s#R(%s,%s)#W找#R怯弱妖#W。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	elseif 类型==1140 then --逐妖蛊虫
	  说明={"降妖伏魔",format("去%s#R(%s,%s)#W处使用“逐妖蛊虫”，然后跟着地上的蛊虫找到妖魔。任务剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	elseif 类型==1141 then --迷幻妖逐妖蛊虫
	  说明={"降妖伏魔",format("蛊虫发现妖魔在%s#R/(%s,%s)#W，快去降伏他吧。任务剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	elseif 类型==1142 then --迷幻妖
	  说明={"降妖伏魔",format("去%s#R(%s,%s)#W找#R迷幻妖#W。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."#W/分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)}
	end
	return 说明
end

function 降妖伏魔:怪物对话内容(id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	local 名称 = 任务数据[标识].名称
	if 任务数据[标识].zhandou then
		对话数据.对话="我正在战斗中，请勿打扰。"
		return 对话数据
	end
	if 名称=="巧智魔" then
		对话数据.对话="金蝉脱壳可是我的拿手好戏，你缠着我也抓不到我。"
		对话数据.选项={"试试再说，看看你有什么本事（战斗）","等我准备好了再来。"}
		if 任务数据[标识].类型==1133 then
			对话数据.对话="金蝉脱壳可是我的拿手好戏，刚试过了，拿我没办法吧。"
			对话数据.选项={"你就是一个跑路小妖魔，看我再来收服你。","等我准备好了再来。"}
		end
	elseif 名称=="梦魇魔" then--梦魇魔
		对话数据.对话="哈哈哈，就你也来挑战我。哈哈哈哈……"
		对话数据.选项={"笑什么笑，小看我，看我刚学的鬼谷道法。","哇，这货笑得好恐怖，等下再来。"}
	elseif 名称=="怯弱妖" then
		if 任务数据[标识].类型==1138 then
			对话数据.对话="你是怎么找到我的，看我跑跑跑，你也追不上。"
			地图处理类:删除单位(任务数据[标识].地图编号,任务数据[标识].单位编号)
			任务数据[标识]=nil
			self:怯弱妖2(id)
		elseif 任务数据[标识].类型==1139 then
			对话数据.对话="三番两次，我都被你累断气了。你怎么这么执着啊，跑不动了。"
			对话数据.选项={"终于逮到你了，看打。","我也跑累了，等下再来。"}
		end
	elseif 名称=="迷幻妖" then
		if 任务数据[标识].类型==1141 then
			对话数据.对话="居然被你的蛊虫找到了，看来今天是在劫难逃啊。"
			对话数据.选项={"废了好大力气才找到你，看打。","准备准备，等下再来。"}
		else
			local 符合=false
			for n=1,#任务数据[标识].队伍组 do
				if 任务数据[标识].队伍组[n]==id then
					符合=true
					break
				end
			end
			if 符合 then
				对话数据.对话="你是怎么找到我的，我给你设个迷幻障目，来看看真实的地方在哪里。"
				if 任务数据[标识].跳转==nil then
					任务数据[标识].跳转=1
					local xy=地图处理类.地图坐标[任务数据[标识].地图编号]:取随机点()
					地图处理类:跳转地图(id,任务数据[标识].地图编号,xy.x,xy.y)
				else
					对话数据.对话="可恶居然被你找到了，看来今天是在劫难逃啊。"
					对话数据.选项={"废了好大力气才找到你，看打。","准备准备，等下再来。"}
				end
			else
				对话数据.对话="你是谁我认识你吗#55"
			end
		end
	elseif 名称=="饿鬼" then
		对话数据.对话="我是一只饿了两千年的鬼，如果你能给我个包子，我就跟你走。"
		对话数据.选项={"给予包子","点错了"}
	elseif 名称=="酒鬼" then
		对话数据.对话="我依酒而生，一天要喝八百缸酒，要是你给我酒喝，我就不为难你。#46"
		对话数据.选项={"给予酒","点错了"}
	elseif 名称=="冥想幽鬼" then
		对话数据.对话="从小到大，从白天到晚上，从鬼到魔……我一只都有许多问题想不明白，谁能帮助我呢？（降妖伏魔参与条件：≥40级，≥3人）"
		对话数据.选项={"随意找队伍中的谁回答你的问题吧，（答错会进入战斗）","等我准备好了再来。"}
	elseif 名称=="勾魂幽灵" then
		对话数据.对话="阴暗的地下世界没有一丝光，没有一点爱，冲破封印的我，决不束手就擒!（降妖伏魔参与条件：≥40级，≥3人）"
		对话数据.选项={"我来降妖伏魔，你乖乖束手就擒吧。","等我准备好了再来。"}
	elseif 名称=="机械游魂" then
		对话数据.对话="来来去去，去去来来，麻麻木木……我不惹你，为什么你却不放过我？（降妖伏魔参与条件：≥40级，≥3人）"
		对话数据.选项={"我来降妖伏魔，你乖乖束手就擒吧。","等我准备好了再来。"}
	elseif 名称=="夜叉" then
		对话数据.对话="几千年来未曾看到太阳，阳光虽然刺眼，但温暖……我决不愿再次回到暗无天日的地狱封印中？（降妖伏魔参与条件：≥40级，≥3人）"
		对话数据.选项={"我来降妖伏魔，你乖乖束手就擒吧。","等我准备好了再来。"}
	elseif 名称=="千年魔灵" then
		对话数据.对话="我也是小妖怪中的极品妖哦，没事不要惹我！#28（降妖伏魔参与条件：≥40级，≥3人）"
		对话数据.选项={"我来降妖伏魔，你乖乖束手就擒吧。","等我准备好了再来。"}
	elseif 名称=="万年魔灵" then
		对话数据.对话="我是妖怪中极品中的极品妖，没事不要惹我！#46（降妖伏魔参与条件：≥40级，≥3人）"
		对话数据.选项={"我来降妖伏魔，你乖乖束手就擒吧。","等我准备好了再来。"}
	end
	return 对话数据
end

function 降妖伏魔:对话事件处理(id,名称,事件,类型,rwid)
	if 名称=="鬼谷道士分身" or 名称=="鬼谷道士" then
		if 事件=="领取降妖伏魔任务" or 事件=="确定" then
			if 玩家数据[id].队伍==0 or 取队伍人数(id)<3 or 取队伍最低等级(玩家数据[id].队伍,40) then 添加最后对话(id,"降妖伏魔参与条件：≥40级，≥3人") return end --测试模式
			if self.活动开关 then
				self:添加降妖伏魔任务(id)
			else
				添加最后对话(id,"现在不是活动时间")
			end
		elseif 事件=="来此炼化镇妖拘魂铃" then
			发送数据(玩家数据[id].连接id,3712)
		elseif 事件=="取消降妖伏魔任务" then --测试模式 测试取消的时候怪会不会消失2
			local 队伍id=玩家数据[id].队伍
			if 队伍id~=nil and 队伍id~=0 then
				for n=1,#队伍数据[队伍id].成员数据 do
					local 成员id=队伍数据[队伍id].成员数据[n]
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1132))
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1133))
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1134))
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1135))
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1138))
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1139))
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1140))
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1141))
					玩家数据[成员id].角色:取消任务(玩家数据[成员id].角色:取任务(1142))
					常规提示(成员id,"你取消了降妖伏魔任务！")
				end
			else
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1132))
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1133))
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1134))
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1135))
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1138))
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1139))
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1140))
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1141))
				玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1142))
				常规提示(id,"你取消了降妖伏魔任务！")
			end
		end
	elseif 名称=="冥想幽鬼" then
		if 玩家数据[id].地图单位 then
			rwid=玩家数据[id].地图单位.标识
		end
		if 玩家数据[id].队伍==0 or 取队伍人数(id)<3 or 取队伍最低等级(玩家数据[id].队伍,40) then 添加最后对话(id,"降妖伏魔参与条件：≥40级，≥3人") return end --测试模式
		if 任务数据[rwid] and 事件=="随意找队伍中的谁回答你的问题吧，（答错会进入战斗）" then
			if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			local 队伍id = 玩家数据[id].队伍
			local a = 取随机数(1,取队伍人数(id))
			local 答题id = 队伍数据[队伍id].成员数据[a]
			for n=1,#队伍数据[队伍id].成员数据 do
				local 临时id=队伍数据[队伍id].成员数据[n]
				if 玩家数据[临时id].答题间隔~=nil and os.time()-玩家数据[临时id].答题间隔 <= 180 then
					添加最后对话(临时id,"你们正在给我解答疑惑中，请稍等片刻……或等3分钟再来吧#113")
					return
				end
			end
			for n=1,#队伍数据[队伍id].成员数据 do
				local 临时id=队伍数据[队伍id].成员数据[n]
				if 临时id~=答题id then
					local 对话="有个问题困扰了我几千年，要是你们中的#Y"..玩家数据[答题id].角色.名称.."#W告诉我答案，我就听你们的。#80"
					发送数据(玩家数据[临时id].连接id,1501,{名称="冥想幽鬼",模型="雾中仙",对话=对话})
					break
				end
			end
			self:设置冥想幽鬼题目(答题id,任务数据[rwid].id)
			return
		elseif 玩家数据[id].铃铛答题~=nil then
			self:完成冥想幽鬼答题(id,玩家数据[id].铃铛答题.任务标识,事件)
		end
	else
		if 玩家数据[id].队伍==0 or 取队伍人数(id)<3 or 取队伍最低等级(玩家数据[id].队伍,40) then 添加最后对话(id,"降妖伏魔参与条件：≥40级，≥3人") return end --测试模式
		if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
		if 事件=="给予包子" then
			玩家数据[id].给予数据={类型=1,id=0,事件="降妖伏魔给予包子",任务id=任务数据[rwid].id}
			发送数据(玩家数据[id].连接id,3530,{道具=玩家数据[id].道具:索要道具1(id),名称="饿鬼",类型="NPC",等级="无"})
			return
		elseif 事件=="给予酒" then
			玩家数据[id].给予数据={类型=1,id=0,事件="降妖伏魔给予酒",任务id=任务数据[rwid].id}
			发送数据(玩家数据[id].连接id,3530,{道具=玩家数据[id].道具:索要道具1(id),名称="酒鬼",类型="NPC",等级="无"})
			return
		elseif 事件=="我来降妖伏魔，你乖乖束手就擒吧。" then
			if 类型==1146 then --勾魂幽灵
				战斗准备类:创建战斗(id,111120,rwid)
				任务数据[rwid].zhandou=true
			elseif 类型==1147 then --机械游魂
				战斗准备类:创建战斗(id,111121,rwid)
				任务数据[rwid].zhandou=true
			elseif 类型==1148 then --夜叉
				战斗准备类:创建战斗(id,111122,rwid)
				任务数据[rwid].zhandou=true
			elseif 类型==1149 then --千年魔灵
				战斗准备类:创建战斗(id,111123,rwid)
				任务数据[rwid].zhandou=true
			elseif 类型==1150 then --万年魔灵
				战斗准备类:创建战斗(id,111124,rwid)
				任务数据[rwid].zhandou=true
			end
			return
		end
		local 符合 = false
		for n=1,#任务数据[rwid].队伍组 do
			if 任务数据[rwid].队伍组[n]==id then
				符合=true
			end
		end
		if 符合 then
			if 事件=="试试再说，看看你有什么本事（战斗）" then --巧智魔1
				战斗准备类:创建战斗(id,111113,rwid)
				任务数据[rwid].zhandou=true
			elseif 事件=="你就是一个跑路小妖魔，看我再来收服你。" then --巧智魔2
				战斗准备类:创建战斗(id,111114,rwid)
				任务数据[rwid].zhandou=true
			elseif 事件=="笑什么笑，小看我，看我刚学的鬼谷道法。" then
				战斗准备类:创建战斗(id,111115,rwid)
				任务数据[rwid].zhandou=true
			elseif 事件=="中了我的计吧，看我的鬼谷道法初阶起步第一式！" then --梦魇魔1
				战斗准备类:创建战斗(id,111116,rwid)
				任务数据[rwid].zhandou=true
			elseif 事件=="终于逮到你了，看打。" then --真怯弱妖
				战斗准备类:创建战斗(id,111117,rwid)
				任务数据[rwid].zhandou=true
			elseif 事件=="废了好大力气才找到你，看打。" then --迷幻妖
				战斗准备类:创建战斗(id,111118,rwid)
				任务数据[rwid].zhandou=true
			end
		else
			常规提示(id,"队伍中有成员任务id不符合要求")
		end
	end
end

function 降妖伏魔:巧智魔1(id)
	local 任务id,ZU=取唯一任务(1132,id)
	local 地图范围={1208,1040,1501,1070,1040,1226,1092}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		玩家id={},
		队伍组=ZU,
		DWZ=ZU,
		名称="巧智魔",
		模型="蜃气妖",
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1132
	}
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话=format("又一个！这次是一只精巧的巧智魔，它足智多谋而且狡猾无比。我发现它的踪迹在#Y/%s(%s,%s)#W/，少侠们准备好了就过去看看吧。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)})
	end
	地图处理类:添加单位(任务id)
end

function 降妖伏魔:巧智魔2(id)
	local 任务id,ZU=取唯一任务(1133,id)
	local 地图范围={1208,1040,1501,1070,1040,1226,1092}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		玩家id={},
		队伍组=ZU,
		DWZ=ZU,
		名称="巧智魔",
		模型="蜃气妖",
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1133
	}
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="鬼谷道士",模型="男人_道士",对话="看来没有收服它，被它跑了，不过没关系，再来一次。（继续尝试收复一次这个妖魔）"})
	end
	地图处理类:添加单位(任务id)
end

function 降妖伏魔:梦魇魔1(id)
	local 任务id,ZU=取唯一任务(1134,id)
	local 地图范围={1208,1040,1501,1070,1040,1226,1092}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		玩家id={},
		队伍组=ZU,
		DWZ=ZU,
		名称="梦魇魔",
		模型="炎魔神",
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1134
	}
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话=format("这个妖魔值得一战，它无所畏惧且强大蛮横!你得有足够的胆色，再去挑战它吧。我发现它的踪迹在#Y%s(%s,%s)#W，少侠们准备好了就过去看看吧。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)})
	end
	地图处理类:添加单位(任务id)

end
function 降妖伏魔:招魂帖(id,ditu,xx,yy)
	local 任务id,ZU=取唯一任务(1135,id)
	local 地图=ditu
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		队伍组=ZU,
		DWZ=ZU,
		x=xx,
		y=yy,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1135
	}
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
	end
	添加最后对话(id,format("看看你包里的新物品“招魂帖”。把它贴在指定位置，可以使得妖魔来自投罗网。去#Y%s(%s,%s)#W使用招魂帖，然后妖魔就会到来。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y))
end

function 降妖伏魔:怯弱妖1(id)
	local 任务id,ZU=取唯一任务(1138,id)
	local 地图范围={1208,1040,1501,1070,1040,1226,1092}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		玩家id={},
		队伍组=ZU,
		DWZ=ZU,
		名称="怯弱妖",
		模型="雾中仙",
		x=xy.x,
		y=xy.y,
		种类="降妖伏魔",
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1138
	}
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话=format("我们要对付一只新的妖魔了，它是一只胆小而怯弱的怯弱妖，不过是身形矫健，敏捷快速。估计，要被他耍好几次了。我发现它的踪迹在#Y%s(%s,%s)#W，少侠们速度赶过去看看吧。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)})
	end
	地图处理类:添加单位(任务id)
end

function 降妖伏魔:怯弱妖2(id)
	local 任务id,ZU=取唯一任务(1139,id)
	local 地图范围={1208,1040,1501,1070,1040,1226,1092}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		玩家id={},
		队伍组=ZU,
		DWZ=ZU,
		名称="怯弱妖",
		模型="雾中仙",
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1139
	}
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
	end
	地图处理类:添加单位(任务id)
end

function 降妖伏魔:迷幻妖(id)
	local 任务id,ZU=取唯一任务(1142,id)
	local 地图范围={1208,1040,1501,1070,1040,1226,1092}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		玩家id={},
		队伍组=ZU,
		DWZ=ZU,
		名称="迷幻妖",
		模型="曼珠沙华",
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1142
	}
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话=format("接下来你们遇到的将是一只狡猾的迷幻妖，想要抓住它，可不容易，我发现它的踪迹在#Y%s(%s,%s)#W少侠们速度赶过去看看吧。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)})
	end
	地图处理类:添加单位(任务id)
end

function 降妖伏魔:逐妖蛊虫(id,ditu,xx,yy)
	local 任务id,ZU=取唯一任务(1140,id)
	local 地图=ditu
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		玩家id={},
		队伍组=ZU,
		DWZ=ZU,
		x=xx,
		y=yy,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1140
	}
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话=format("有的妖魔行踪隐秘，所以你得使用包裹里的物品“逐妖蛊虫”，让这个蛊虫给你带路。去#Y%s(%s,%s)#W然后跟着它，它会找到妖魔的。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)})
	end
end

function 降妖伏魔:使用逐妖蛊虫(id)
	local 任务id,ZU=取唯一任务(1141,id)
	local 地图范围={1208,1040,1501,1070,1040,1226,1092}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		玩家id={},
		队伍组=ZU,
		DWZ=ZU,
		名称="迷幻妖",
		模型="曼珠沙华",
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1141
	}
	local 队伍id=玩家数据[id].队伍
	任务数据[玩家数据[id].角色:取任务(1140)] = nil --清空逐妖蛊虫1任务
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色:取消任务(玩家数据[临时id].角色:取任务(1140)) --取消逐妖蛊虫1任务
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话=format("跟着地上的蛊虫，然后相符找到的妖魔吧。")})
	end
	地图处理类:添加单位(任务id)
end

function 降妖伏魔:饿鬼()
  local 地图范围={1110,1092,1514,1091,1070,1193} --大唐国境（必刷）、傲来国、长寿郊外、长寿村、江南野外、朱紫国、花果山的四种场景投放。
  local 刷新地图={}
  for n=1,#地图范围 do
	local 地图=地图范围[n]
	for i=1,3 do
	  local xy=地图处理类.地图坐标[地图]:取随机点()
	  local 任务id=取唯一任务(1143,id)
	  local 造型="炎魔神"
	  任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=600,
		销毁=true,
		玩家id=id,
		队伍组={},
		名称="饿鬼",
		模型=造型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1143
	  }
	  地图处理类:添加单位(任务id)
	end
	刷新地图[#刷新地图+1] = 取地图名称(地图)
  end
  广播消息({内容=format("#S(降妖伏魔)#W一群饿鬼,出现在#P %s、%s、%s、%s、%s、%s#W场景内".."#"..取随机数(1,110),刷新地图[1],刷新地图[2],刷新地图[3],刷新地图[4],刷新地图[5],刷新地图[6]),频道="hd"})
end

function 降妖伏魔:酒鬼()
  local 地图范围={1110,1092,1514,1091,1070,1193} --大唐国境（必刷）、傲来国、长寿郊外、长寿村、江南野外、朱紫国、花果山的四种场景投放。
  local 刷新地图={}
  for n=1,#地图范围 do
	local 地图=地图范围[n]
	for i=1,3 do
	  local xy=地图处理类.地图坐标[地图]:取随机点()
	  local 任务id="_1144_"..os.time().."_"..取随机数(88,99999999)
	  local 造型="雨师"
	  任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=600,
		玩家id=id,
		队伍组={},
		销毁=true,
		名称="酒鬼",
		模型=造型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1144
	  }
	  地图处理类:添加单位(任务id)
	end
	刷新地图[#刷新地图+1] = 取地图名称(地图)
  end
  广播消息({内容=format("#S(降妖伏魔)#W一群酒鬼,出现在#P %s、%s、%s、%s、%s、%s#W场景内".."#"..取随机数(1,110),刷新地图[1],刷新地图[2],刷新地图[3],刷新地图[4],刷新地图[5],刷新地图[6]),频道="hd"})
end

function 降妖伏魔:冥想幽鬼()
  local 地图范围={1110,1092,1514,1091,1070,1193} --大唐国境（必刷）、傲来国、长寿郊外、长寿村、江南野外、朱紫国、花果山的四种场景投放。
  local 刷新地图={}
  for n=1,#地图范围 do
	local 地图=地图范围[n]
	for i=1,4 do
	  local xy=地图处理类.地图坐标[地图]:取随机点()
	  local 任务id="_1145_"..os.time().."_"..取随机数(88,99999999)
	  任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=600,
		玩家id=id,
		销毁=true,
		队伍组={},
		名称="冥想幽鬼",
		模型="雾中仙",
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1145
	  }
	  地图处理类:添加单位(任务id)
	end
	刷新地图[#刷新地图+1] = 取地图名称(地图)
  end
  广播消息({内容=format("#S(降妖伏魔)#W冥想幽鬼,出现在#P %s、%s、%s、%s、%s、%s#W场景内".."#"..取随机数(1,110),刷新地图[1],刷新地图[2],刷新地图[3],刷新地图[4],刷新地图[5],刷新地图[6]),频道="hd"})
end

function 降妖伏魔:设置冥想幽鬼题目(id,任务id)
	local 序列=取随机数(1,#科举题库)
	local 正确答案=科举题库[序列][4]
	local 随机答案={}
	for n=2,4 do
		随机答案[n-1]={答案=科举题库[序列][n],序列=取随机数(1,9999)}
	end
	table.sort(随机答案,function(a,b) return a.序列>b.序列 end )
	local 显示答案={}
	for n=1,3 do
		显示答案[n]=随机答案[n].答案
	end
	玩家数据[id].铃铛答题={题目=科举题库[序列][1],答案=显示答案,正确答案=正确答案,任务标识=任务id}
	发送数据(玩家数据[id].连接id,1501,{名称="冥想幽鬼",模型="雾中仙",对话=format("#W/%s", 玩家数据[id].铃铛答题.题目),选项= 玩家数据[id].铃铛答题.答案})
end

function 降妖伏魔:勾魂幽灵()
  local 地图范围={1110,1092,1514,1091,1070,1193} --大唐国境（必刷）、傲来国、长寿郊外、长寿村、江南野外、朱紫国、花果山的四种场景投放。
  local 刷新地图={}
  for n=1,#地图范围 do
	local 地图=地图范围[n]
	for i=1,4 do
	  local xy=地图处理类.地图坐标[地图]:取随机点()
	  local 任务id="_1146_"..os.time().."_"..取随机数(88,99999999)
	  local 造型="进阶夜罗刹"
	  任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=600,
		销毁=true,
		玩家id=id,
		队伍组={},
		名称="勾魂幽灵",
		模型=造型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1146
	  }
	  地图处理类:添加单位(任务id)
	end
	刷新地图[#刷新地图+1] = 取地图名称(地图)
  end
  广播消息({内容=format("#S(降妖伏魔)#W勾魂幽灵,出现在#P %s、%s、%s、%s、%s、%s#W场景内".."#"..取随机数(1,110),刷新地图[1],刷新地图[2],刷新地图[3],刷新地图[4],刷新地图[5],刷新地图[6]),频道="hd"})
end

function 降妖伏魔:机械游魂()
  local 地图范围={1110,1092,1514,1091,1070,1193} --大唐国境（必刷）、傲来国、长寿郊外、长寿村、江南野外、朱紫国、花果山的四种场景投放。
  local 刷新地图={}
  for n=1,#地图范围 do
	local 地图=地图范围[n]
	for i=1,4 do
	  local xy=地图处理类.地图坐标[地图]:取随机点()
	  local 任务id="_1147_"..os.time().."_"..取随机数(88,99999999)
	  local 造型="机关兽"
	  任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=600,
		玩家id=id,
		销毁=true,
		队伍组={},
		名称="机械游魂",
		模型=造型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1147
	  }
	  地图处理类:添加单位(任务id)
	end
	刷新地图[#刷新地图+1] = 取地图名称(地图)
  end
  广播消息({内容=format("#S(降妖伏魔)#W机械游魂,出现在#P %s、%s、%s、%s、%s、%s#W场景内".."#"..取随机数(1,110),刷新地图[1],刷新地图[2],刷新地图[3],刷新地图[4],刷新地图[5],刷新地图[6]),频道="hd"})
end

function 降妖伏魔:夜叉()
  local 地图范围={1110,1092,1514,1091,1070,1193} --大唐国境（必刷）、傲来国、长寿郊外、长寿村、江南野外、朱紫国、花果山的四种场景投放。
  local 刷新地图={}
  for n=1,#地图范围 do
	local 地图=地图范围[n]
	for i=1,4 do
	  local xy=地图处理类.地图坐标[地图]:取随机点()
	  local 任务id="_1148_"..os.time().."_"..取随机数(88,99999999)
	  local 造型="幽灵"
	  任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=600,
		玩家id=id,
		销毁=true,
		队伍组={},
		名称="夜叉",
		模型=造型,
		变异=true,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1148
	  }
	  地图处理类:添加单位(任务id)
	end
	刷新地图[#刷新地图+1] = 取地图名称(地图)
  end
  广播消息({内容=format("#S(降妖伏魔)#W一群机械游魂,出现在#P %s、%s、%s、%s、%s、%s#W场景内".."#"..取随机数(1,110),刷新地图[1],刷新地图[2],刷新地图[3],刷新地图[4],刷新地图[5],刷新地图[6]),频道="hd"})
end

function 降妖伏魔:千年魔灵()
  local 地图范围={1110,1092,1091} --大唐国境（必刷）、傲来国、长寿郊外、长寿村、江南野外、朱紫国、花果山的四种场景投放。
  local 刷新地图={}
  for n=1,#地图范围 do
	local 地图=地图范围[n]
	for i=1,3 do
	  local xy=地图处理类.地图坐标[地图]:取随机点()
	  local 任务id="_1149_"..os.time().."_"..取随机数(88,99999999)
	  local 造型="帮派妖兽"
	  任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=900,
		玩家id=id,
		销毁=true,
		队伍组={},
		名称="千年魔灵",
		模型=造型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1149
	  }
	  地图处理类:添加单位(任务id)
	end
	刷新地图[#刷新地图+1] = 取地图名称(地图)
  end
  广播消息({内容=format("#S(降妖伏魔)#W听说#Y千年魔灵#W在#P %s、%s、%s#W现身了，请得道高手速速前往收服".."#"..取随机数(1,110),刷新地图[1],刷新地图[2],刷新地图[3]),频道="hd"})
end

function 降妖伏魔:万年魔灵()
  local 地图范围={1110,1092,1070} --大唐国境（必刷）、傲来国、长寿郊外、长寿村、江南野外、朱紫国、花果山的四种场景投放。
  local 刷新地图={}
  for n=1,#地图范围 do
	local 地图=地图范围[n]
	for i=1,2 do
	  local xy=地图处理类.地图坐标[地图]:取随机点()
	  local 任务id="_1150_"..os.time().."_"..取随机数(88,99999999)
	  local 造型="九头精怪"
	  任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=900,
		玩家id=id,
		销毁=true,
		队伍组={},
		名称="万年魔灵",
		模型=造型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=1150
	  }
	  地图处理类:添加单位(任务id)
	end
	刷新地图[#刷新地图+1] = 取地图名称(地图)
  end
  广播消息({内容=format("#S(降妖伏魔)#W听说#Y万年魔灵#W在#P %s、%s、%s#W现身了，请得道高手速速前往收服".."#"..取随机数(1,110),刷新地图[1],刷新地图[2],刷新地图[3]),频道="hd"})
end


function 降妖伏魔:完成巧智魔1(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	self:巧智魔2(id组[1])
end
function 降妖伏魔:完成巧智魔2(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		玩家数据[id].角色:刷新任务跟踪()
		local 经验=qz(等级*取随机数(1000,1250))
		local 银子=等级*120+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"巧智魔2",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"巧智魔2",1)
		if 取随机数()<=HDPZ["铃铛：小怪"].爆率 then
			local 链接 = {提示="#S(降妖伏魔)#G巧智魔#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：小怪"].ITEM),"铃铛：小怪")
							if 数量== 9999 then --环
								玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
										玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
	发送数据(玩家数据[id组[1]].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话="是否要继续领取降妖伏魔任务？如取消可去鬼谷道士处再次领取。",选项={"确定","取消"}})
end
function 降妖伏魔:完成梦魇魔1(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		玩家数据[id].角色:刷新任务跟踪()
		local 经验=qz(等级*取随机数(1060,1300))
		local 银子=等级*130+6000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"梦魇魔2",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"梦魇魔2",1)
		if 取随机数()<=HDPZ["铃铛：小怪"].爆率 then
			local 链接 = {提示="#S(降妖伏魔)#G梦魇魔#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：小怪"].ITEM),"铃铛：小怪")
							if 数量== 9999 then --环
								玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
										玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
	发送数据(玩家数据[id组[1]].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话="是否要继续领取降妖伏魔任务？如取消可去鬼谷道士处再次领取。",选项={"确定","取消"}})
end
function 降妖伏魔:完成梦魇魔2(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(1135)) --取消招魂贴任务
		local 经验=qz(等级*取随机数(1060,1350))
		local 银子=等级*140+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"梦魇魔2",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"梦魇魔2",1)
		if 取随机数()<=HDPZ["铃铛：小怪"].爆率 then
			local 链接 = {提示="#S(降妖伏魔)#G梦魇魔#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：小怪"].ITEM),"铃铛：小怪")
							if 数量== 9999 then --环
								玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
										玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
	发送数据(玩家数据[id组[1]].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话="是否要继续领取降妖伏魔任务？如取消可去鬼谷道士处再次领取。",选项={"确定","取消"}})
end
function 降妖伏魔:完成怯弱妖(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		玩家数据[id].角色:刷新任务跟踪()
		local 经验=qz(等级*取随机数(1060,1350))
		local 银子=等级*140+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"怯弱妖",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"怯弱妖",1)
		if 取随机数()<=HDPZ["铃铛：小怪"].爆率 then
			local 链接 = {提示="#S(降妖伏魔)#G怯弱妖#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：小怪"].ITEM),"铃铛：小怪")
							if 数量== 9999 then --环
								玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
										玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
	发送数据(玩家数据[id组[1]].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话="是否要继续领取降妖伏魔任务？如取消可去鬼谷道士处再次领取。",选项={"确定","取消"}})
end
function 降妖伏魔:完成迷幻妖(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		玩家数据[id].角色:刷新任务跟踪()
		local 经验=qz(等级*取随机数(1060,1350))
		local 银子=等级*140+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"迷幻妖",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"迷幻妖",1)
		if 取随机数()<=HDPZ["铃铛：小怪"].爆率 then
			local 链接 = {提示="#S(降妖伏魔)#G迷幻妖#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：小怪"].ITEM),"铃铛：小怪")
							if 数量== 9999 then --环
								玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
										玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
	发送数据(玩家数据[id组[1]].连接id,1501,{名称="鬼谷道士分身",模型="男人_道士",对话="是否要继续领取降妖伏魔任务？如取消可去鬼谷道士处再次领取。",选项={"确定","取消"}})
end
function 降妖伏魔:完成勾魂幽灵(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		local 经验=qz(等级*取随机数(1060,1350))
		local 银子=等级*140+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"勾魂幽灵",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"勾魂幽灵",1)
		if 取随机数()<=HDPZ["铃铛：小怪"].爆率 then
			local 链接 = {提示="#S(降妖伏魔)#G勾魂幽灵#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：小怪"].ITEM),"铃铛：小怪")
							if 数量== 9999 then --环
								玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
										玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
end
function 降妖伏魔:完成机械游魂(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		local 经验=qz(等级*取随机数(1060,1250))
		local 银子=等级*140+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"机械游魂",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"机械游魂",1)
		if 取随机数()<=HDPZ["铃铛：小怪"].爆率 then
			local 链接 = {提示="#S(降妖伏魔)#G机械游魂#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：小怪"].ITEM),"铃铛：小怪")
							if 数量== 9999 then --环
								玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
										玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
end
function 降妖伏魔:完成夜叉(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		local 经验=qz(等级*取随机数(1060,1250))
		local 银子=等级*140+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"夜叉",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"夜叉",1)
		if 取随机数()<=HDPZ["铃铛：小怪"].爆率 then
			local 链接 = {提示="#S(降妖伏魔)#G夜叉#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：小怪"].ITEM),"铃铛：小怪")
							if 数量== 9999 then --环
								玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
										玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
end
function 降妖伏魔:完成千年魔灵(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		local 经验=qz(等级*取随机数(1560,2050))
		local 银子=等级*300+20000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：千年魔灵"].经验,"千年魔灵",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：千年魔灵"].银子,"千年魔灵",1)
		if 取随机数()<=HDPZ["铃铛：千年魔灵"].爆率 then
			local 链接 = {提示=format("#S(降妖伏魔)#Y【千年魔灵】：连妖怪中的极品都敢打？#G%s#Y，我拿",玩家数据[id].角色.名称),频道="hd",结尾=format("#Y打死你！")}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：千年魔灵"].ITEM),"铃铛：千年魔灵")
							if 数量== 9999 then --环
							玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
							玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
							end
		end
	end
end
function 降妖伏魔:完成万年魔灵(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		local 经验=qz(等级*取随机数(1260,1350))+100000
		local 银子=等级*888+60000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：万年魔灵"].经验,"万年魔灵",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：万年魔灵"].银子,"万年魔灵",1)
		if 取随机数()<=HDPZ["铃铛：万年魔灵"].爆率 then
		local 链接 = {提示=format("#S(降妖伏魔)#Y【万年魔灵】：连妖怪中的极品都敢打？#G%s#Y，我拿",玩家数据[id].角色.名称),频道="hd",结尾=format("#Y打死你！")}
		local 名称,数量,参数=生成产出(产出物品计算(HDPZ["铃铛：万年魔灵"].ITEM),"铃铛：万年魔灵")
		if 数量== 9999 then --环
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
	else
		玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
	end
	end
	end
end

function 降妖伏魔:完成饿鬼(id,任务id)
	if 任务数据[任务id]==nil then
		常规提示(id,"#Y/呀被人抢先一步")
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
		local id=队伍数据[玩家数据[id].队伍].成员数据[n]
		local 等级=玩家数据[id].角色.等级
		local 经验=qz(等级*取随机数(1060,1150))
		local 银子=等级*110+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"饿鬼",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"饿鬼",1)
		if 取随机数()<=20 then
			local 奖励参数=取随机数(1,120)
			local 链接 = {提示="#S(降妖伏魔)#G饿鬼#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
			if 奖励参数<=20 then
				local 名称="金柳露"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=25 then
				local 名称="超级金柳露"
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=29 then
				local 名称="召唤兽内丹"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=31 then
				local 名称="高级召唤兽内丹"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=36 then
				local 名称="魔兽要诀"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=37 then
				local 名称="高级魔兽要诀"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=39 then
				local 名称="五宝盒"
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=40 then
				local 名称="神兜兜"
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=55 then
				local 名称=取强化石()
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=56 then
				local 名称="装备特效宝珠"
				if 取随机数()<15 then
					名称="陨铁"
				end
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=60 then
				local 名称=取宝石()
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=63 then
				local 名称="附魔宝珠"
				玩家数据[id].道具:给予超链接道具(id,名称,取随机数(14,16)*10,nil,链接)
			else
				local 名称="镇妖拘魂铃"
				玩家数据[id].道具:给予道具(id,名称,1,nil,链接)
			end
		end
	end
	添加最后对话(id,format("#17真好那我就跟你走了"))
end
function 降妖伏魔:完成酒鬼(id,任务id)
	if 任务数据[任务id]==nil then
		常规提示(id,"#Y/呀被人抢先一步")
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
		local id=队伍数据[玩家数据[id].队伍].成员数据[n]
		local 等级=玩家数据[id].角色.等级
		local 经验=qz(等级*取随机数(1060,1150))
		local 银子=等级*110+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"酒鬼",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"酒鬼",1)
		if 取随机数()<=20 then
			local 奖励参数=取随机数(1,120)
			local 链接 = {提示="#S(降妖伏魔)#G酒鬼#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
			if 奖励参数<=20 then
				local 名称="金柳露"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=25 then
				local 名称="超级金柳露"
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=29 then
				local 名称="召唤兽内丹"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=31 then
				local 名称="高级召唤兽内丹"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=36 then
				local 名称="魔兽要诀"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=37 then
				local 名称="高级魔兽要诀"
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=39 then
				local 名称="五宝盒"
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=40 then
				local 名称="神兜兜"
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=55 then
				local 名称=取强化石()
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=56 then
				local 名称="装备特效宝珠"
				if 取随机数()<15 then
					名称="陨铁"
				end
				玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
			elseif 奖励参数<=60 then
				local 名称=取宝石()
				玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
			elseif 奖励参数<=63 then
				local 名称="附魔宝珠"
				玩家数据[id].道具:给予超链接道具(id,名称,取随机数(14,16)*10,nil,链接)
			else
				local 名称="镇妖拘魂铃"
				玩家数据[id].道具:给予道具(id,名称,1,nil,链接)
			end
		end
	end
	添加最后对话(id,format("#92美酒配小菜，大爷我谁都不会爱！"))
end

function 降妖伏魔:完成冥想幽鬼答题(id,任务id,答案)
	if 任务数据[任务id]==nil then
		常规提示(id,"#Y/呀被人抢先一步")
		return
	end
	local 正确=false
	if 答案==玩家数据[id].铃铛答题.正确答案 then
		正确=true
	end
	if 正确 then
		地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
		任务数据[任务id]=nil
		for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			local id = 队伍数据[玩家数据[id].队伍].成员数据[n]
			玩家数据[id].答题间隔=nil
			local 等级=玩家数据[id].角色.等级
			local 经验=qz(等级*取随机数(1060,1150))
			local 银子=等级*110+5000
			玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"冥想幽鬼",1)
			玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"冥想幽鬼",1)
			if 取随机数()<=20 then
				local 奖励参数=取随机数(1,120)
				local 链接 = {提示="#S(降妖伏魔)#G冥想幽鬼#Y被收服了，一阵烟消云散之后留下了宝贝",频道="hd",结尾=format("#Y给大侠#G%s#26#Y！",玩家数据[id].角色.名称)}
				if 奖励参数<=20 then
					local 名称="金柳露"
					玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
				elseif 奖励参数<=25 then
					local 名称="超级金柳露"
					玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
				elseif 奖励参数<=29 then
					local 名称="召唤兽内丹"
					玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
				elseif 奖励参数<=31 then
					local 名称="高级召唤兽内丹"
					玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
				elseif 奖励参数<=36 then
					local 名称="魔兽要诀"
					玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
				elseif 奖励参数<=37 then
					local 名称="高级魔兽要诀"
					玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
				elseif 奖励参数<=39 then
					local 名称="五宝盒"
					玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
				elseif 奖励参数<=40 then
					local 名称="神兜兜"
					玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
				elseif 奖励参数<=55 then
					local 名称=取强化石()
					玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
				elseif 奖励参数<=56 then
					local 名称="装备特效宝珠"
					if 取随机数()<15 then
						名称="陨铁"
					end
					玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
				elseif 奖励参数<=60 then
					local 名称=取宝石()
					玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
				elseif 奖励参数<=63 then
					local 名称="附魔宝珠"
					玩家数据[id].道具:给予超链接道具(id,名称,取随机数(14,16)*10,nil,链接)
				else
					local 名称="镇妖拘魂铃"
					玩家数据[id].道具:给予道具(id,名称,1,nil,链接)
				end
			end
		end
	else
		for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			local id = 队伍数据[玩家数据[id].队伍].成员数据[n]
			玩家数据[id].答题间隔=os.time()
		end
		战斗准备类:创建战斗(玩家数据[id].队伍,111119,任务id)
	end
	玩家数据[id].铃铛答题=nil
end

function 降妖伏魔:完成冥想幽鬼战斗(任务id,id组)
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
		local id=id组[n]
		local 等级=玩家数据[id].角色.等级
		local 经验=qz(等级*取随机数(1060,1250))
		local 银子=qz(等级*取随机数(120,150))+5000
		玩家数据[id].角色:添加经验(经验*HDPZ["铃铛：小怪"].经验,"冥想幽鬼",1)
		玩家数据[id].角色:添加银子(银子*HDPZ["铃铛：小怪"].银子,"冥想幽鬼",1)

	end
end

function 降妖伏魔:加载奖池()
	self.奖池[1] = {
		名称="高级魔兽要诀",
		说明="",
		参数={},
	}
	self.奖池[2] = {
		名称="魔兽要诀",
		说明="",
		参数={},
	}
	self.奖池[3] = {
		名称="修炼果",
		说明="",
		参数={},
	}
	self.奖池[4] = {
		名称="九转金丹",
		说明="",
		参数={},
	}
	self.奖池[5] = {
		名称="金柳露",
		说明="",
		参数={},
	}
	self.奖池[6] = {
		名称="超级金柳露",
		说明="",
		参数={},
	}
	self.奖池[7] = {
		名称="彩果",
		说明="",
		参数={},
	}
	self.奖池[8] = {
		名称="五宝盒",
		说明="",
		参数={},
	}
	self.奖池[9] = {
		名称="太阳石",
		说明="",
		参数={},
	}
	self.奖池[10] = {
		名称="舍利子",
		说明="",
		参数={},
	}
	self.奖池[11] = {
		名称="红玛瑙",
		说明="",
		参数={},
	}
	self.奖池[12] = {
		名称="黑宝石",
		说明="",
		参数={},
	}
	self.奖池[13] = {
		名称="星辉石",
		说明="",
		参数={},
	}
	self.奖池[14] = {
		名称="月亮石",
		说明="",
		参数={},
	}
	self.奖池[15] = {
		名称="经验",
		说明="",
		参数={},
	}
	self.奖池[16] = {
		名称="特赦令牌",
		说明="",
		参数={},
	}
	self.奖池[17] = {
		名称="玄武石",
		说明="",
		参数={},
	}
	self.奖池[18] = {
		名称="朱雀石",
		说明="",
		参数={},
	}
	self.奖池[19] = {
		名称="白虎石",
		说明="",
		参数={},
	}
	self.奖池[20] = {
		名称="青龙石",
		说明="",
		参数={},
	}
	self.奖池[21] = {
		名称="青龙石",
		说明="",
		参数={},
	}
	self.奖池[22] = {
		名称="经验",
		说明="",
		参数={},
	}
	self.奖池[23] = {
		名称="经验",
		说明="",
		参数={},
	}
	self.奖池[24] = {
		名称="金柳露",
		说明="",
		参数={},
	}
	self.奖池[25] = {
		名称="超级金柳露",
		说明="",
		参数={},
	}
	self.奖池[26] = {
		名称="玄武石",
		说明="",
		参数={},
	}
	self.奖池[27] = {
		名称="朱雀石",
		说明="",
		参数={},
	}
	self.奖池[28] = {
		名称="白虎石",
		说明="",
		参数={},
	}
	self.奖池[29] = {
		名称="青龙石",
		说明="",
		参数={},
	}
	self.奖池[30] = {
		名称="白虎石",
		说明="",
		参数={},
	}
	self.奖池[31] = {
		名称="光芒石",
		说明="",
		参数={},
	}
end

function 降妖伏魔:铃铛抽奖(连接id,id,数据)
	local id  = id
	local 选择数量 = 数据.选择个数
	local 发送道具 = {}
	local 奖励道具 = {}
	if not 玩家数据[id].道具:判定背包道具(id,"镇妖拘魂铃",选择数量) then
		常规提示(id,"#Y镇妖拘魂铃数量不足！")
		return
	end
	if 玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"镇妖拘魂铃",选择数量) then
		for n=1,选择数量 do
			if 发送道具[n] == nil then
				发送道具[n] = {}
			end
			for i=1,5 do
				发送道具[n][i]=DeepCopy(self.奖池[取随机数(1,#self.奖池)])
				if i==5 then
					奖励道具[#奖励道具+1]=发送道具[n][i]
				end
			end
		end
		玩家数据[id].铃铛抽奖=奖励道具
		发送数据(连接id,3713,{物品数据=发送道具,选择个数=选择数量})
	end
end

function 降妖伏魔:铃铛处理(连接id,id,数据)
	local id  = id
	local 奖励选择 = 数据.奖励选择
	local 名称 = 玩家数据[id].铃铛抽奖[奖励选择].名称
	if 名称=="太阳石" or 名称=="舍利子" or 名称=="红玛瑙" or 名称=="黑宝石" or 名称=="月亮石" or 名称=="光芒石" then
	   玩家数据[id].道具:给予道具(id,名称,取随机数(1,2))
	   常规提示(id,"#Y你获得了#G"..名称)
	elseif 名称=="经验" then
	   local 数额=取随机数(120000,200000)
	   玩家数据[id].角色:添加经验(数额,"铃铛抽奖",1)
	elseif 名称=="九转金丹" then
	   玩家数据[id].道具:给予道具(id,"九转金丹",取随机数(5,10)*10)
	   常规提示(id,"#Y你获得了#G"..名称)
	else
	   玩家数据[id].道具:给予道具(id,名称,1)
	   常规提示(id,"#Y你获得了#G"..名称)
	end
	玩家数据[id].铃铛抽奖=nil
	发送数据(连接id,3714)
end


function 降妖伏魔:使用招魂帖(id,ditu,xx,yy)
end

function 降妖伏魔:招魂帖梦魇魔(任务id)
end
return 降妖伏魔


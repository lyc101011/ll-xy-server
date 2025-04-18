-- @Author: baidwwy
-- @Date:   2024-06-13 17:01:21
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-06-22 18:13:00
local 二八星宿 = class()

function 二八星宿:初始化()
    self.星宿名称={
		[1]="角木蛟"
		,[2]="亢金龙"
		,[3]="氐土貉"
		,[4]="房日兔"
		,[5]="心月狐"
		,[6]="尾火虎"
		,[7]="箕水豹"
		,[8]="井木犴"
		,[9]="鬼金羊"
		,[10]="柳土獐"
		,[11]="星日马"
		,[12]="张月鹿"
		,[13]="翼火蛇"
		,[14]="轸水蚓"
		,[15]="奎木狼"
		,[16]="娄金狗"
		,[17]="胃土雉"
		,[18]="昴日鸡"
		,[19]="毕月乌"
		,[20]="觜火猴"
		,[21]="参水猿"
		,[22]="斗木獬"
		,[23]="牛金牛"
		,[24]="女土蝠"
		,[25]="虚日鼠"
		,[26]="危月燕"
		,[27]="室火猪"
		,[28]="壁水貐"
	}
end

function 二八星宿:活动定时器()
	if 服务端参数.分钟+0==0 and 服务端参数.秒+0==1 then
		self:刷新资源()
	end
end

function 二八星宿:刷新资源()
	local dtmc=""
    local 地图范围={1140,1207,1142,1092,1514,1506,1116,1040,1042,1091,1041,1210,1135,1111,1273,1177,1178,1186,1187,1174,1201,1131,1001,1198,1002,1173,1512,1110,1218,1146}
    for i=1,7 do
    	local sj=取随机数(1,#地图范围)
		if i==7 then
		    dtmc=dtmc..取地图名称(地图范围[sj])
		else
			dtmc=dtmc..取地图名称(地图范围[sj]).."、"
		end
		local 任务id=取唯一任务(104)
		local 地图=地图范围[sj]
		local xy=地图处理类.地图坐标[地图]:取随机点()
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3500,
			名称=self.星宿名称[取随机数(1,#self.星宿名称)],
			模型="天兵",
			变异=true,
			x=xy.x,
			y=xy.y,
			地图编号=地图,
			地图名称=取地图名称(地图),
			销毁=true,
			类型=104
		}
		地图处理类:添加单位(任务id)
		table.remove(地图范围,sj)
    end
	广播消息({内容=format("传说中的二十八星宿来到凡间寻找有缘人，大家赶快前往#Y%s#W迎接他们吧！#81",dtmc),频道="xt"})
end

function 二八星宿:怪物对话内容(id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 任务数据[标识].zhandou==nil then
		对话数据.对话="听说世间有二十八人，身上会现出二十八星宿字样，他们拥有开启天地灵气之门的能力。我一直都在苦苦寻觅，你是那二十八人中的一员吗#55快来让我瞧你的本事吧#80"
		对话数据.选项={"那就让我秀一下吧","额……我想我不是你要找到人，祝你好运，再见…"}
	else
		对话数据.对话="我正在战斗中，请勿打扰。"
	end
	return 对话数据
end

function 二八星宿:怪物对话处理(id,名称,事件,类型,rwid)
	if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
	if 取队伍人数(id)<5 and 调试模式==false then 常规提示(id,"#Y挑战二八星宿最少必须由五人进行") return  end
	if 取等级要求(id,60)==false and 调试模式==false then 常规提示(id,"#Y/队伍中有成员等级不符合要求") return  end
	if 事件=="那就让我秀一下吧" then
		战斗准备类:创建战斗(id,100009,rwid)
        任务数据[rwid].zhandou=true
	end
end

function 二八星宿:战斗胜利处理(id组,战斗类型,任务id)
	local id=id组[1]
	if 任务数据[任务id]==nil then
		return
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	for n=1,#id组 do
	    local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(1000,1100)
		local 银子=等级*550+30000
		玩家数据[cyid].角色:添加经验(经验*HDPZ["二十八星宿"].经验,"二八星宿",1)
		玩家数据[cyid].角色:添加银子(qz(银子*HDPZ["二十八星宿"].银子),"二八星宿",1)
		if 玩家数据[cyid].角色.星宿==nil then
		    玩家数据[cyid].角色.星宿=0
		end
		if 玩家数据[cyid].角色.星宿<28 then
		    玩家数据[cyid].角色.星宿=玩家数据[cyid].角色.星宿+1
		    if 玩家数据[cyid].角色.星宿==28 then
		        玩家数据[cyid].角色:添加称谓("落入凡间的星灵")
		        广播消息({内容=format("原来#Y%s#W是二十八星宿来到凡间寻找的有缘人，恭喜他获得“落入凡间的星灵”称谓。",玩家数据[cyid].角色.名称),频道="xt"})
		    end
		end
		if 取随机数()<=HDPZ["二十八星宿"].爆率 then
			local 链接 = {提示=format("#S(二十八星宿)#G/%s#W大侠莫非就是传说中可以开启天地灵气之门的有缘人#80，请收好宝贝",玩家数据[cyid].角色.名称),频道="xt",结尾="#W。"}
	                    	local 名称,数量,参数=生成产出(产出物品计算(HDPZ["二十八星宿"].ITEM),"二十八星宿")
	                    	if 数量== 9999 then --环
	                    		玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
	                    	else
	                    	            玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
	                    	end
		end
	end
end

return 二八星宿
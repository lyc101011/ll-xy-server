-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 16:50:49
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:16
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1142]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 2 then
		wb[1] = "这里的孙婆婆很和蔼的，弟子们有不明白的地方，她总是耐心教导。"
		wb[2] = "长安城真的像姑娘们说得那样繁花似锦么？真想哪天去看一看。"
		wb[3] = "这里就是远近闻名的女儿村，拜师的话请找孙婆婆。"
		wb[4] = "鸳鸯双栖蝶双飞，满眼春色惹人醉。"
		return {"女人_翠花","翠花",wb[sj(1,#wb)]}
	elseif 编号 == 3 then
		wb[1] = "女儿村的姑娘们个个能歌善舞，我家女儿也一定要好好学学。"
		wb[2] = "最近村子里不太平啊，好多姑娘失踪，我女儿前天也不见了，真是急死了。"
		wb[3] = "女儿村的姑娘们个个生的俊俏，看着就让人喜爱啊！"
		wb[4] = "我的女儿是我唯一的依靠，我就盼着她能平平安安的生活，以后嫁个好人家。"
		return {"女人_王大嫂","栗栗娘",wb[sj(1,#wb)]}
	elseif 编号 == 4 then
		wb[1] = "青琉璃女侠是我的恩人，我一直在想着报答她。"
		wb[2] = "最近村子里失踪了好几个姑娘，家里人都担心死了，特别是那个栗栗儿的娘，天天在村子附近寻找女儿，真是作孽啊。"
		wb[3] = "婆婆传授的法术是用来防身用的，可不是用来逞强的。"
		xx = {"购买暗器","我还要逛逛"}
		return {"普陀山_接引仙女","柳飞絮",wb[sj(1,#wb)],xx}
	elseif 编号 == 5 then
		wb[1] = "上次红线童子送我了个木偶，真好玩，不过只有一个是不是太孤独了。下次再叫他送我个，两个人就不孤独了。"
		wb[2] = "你有什么新奇的玩具啊，绿儿一个人好无聊哦！"
		wb[3] = "我的意中人是个盖世英雄，他要陪我玩丢手绢，嗯，还要把他的糖糖分给我吃！"
		local 任务id
		if 玩家数据[数字id].角色:取任务(301)~=0 or 玩家数据[数字id].角色:取任务(302)~=0 then --青龙玄武
			wb={"你找我有什么事情吗？"}
			xx={}
			任务id= 玩家数据[数字id].角色:取任务(301)
			if 任务id~=0 and 任务数据[任务id].人物=="绿儿" then
				xx[#xx+1] = "青龙任务"
			end
			任务id= 玩家数据[数字id].角色:取任务(302)
			if 任务id~=0 and 任务数据[任务id].人物=="绿儿" then
				xx[#xx+1] = "玄武任务"
			end
			xx[#xx+1] = "没什么，我只是看看"
			return {"女人_绿儿","绿儿",wb[1],xx}
		end
		return {"女人_绿儿","绿儿",wb[sj(1,#wb)]}
	elseif 编号 == 1 then
		wb[1] = "我送阁下回长安吧。"
		local xx = {"是的我要去","我还要逛逛"}
		return {"女人_丫鬟","接引女使",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1142 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="接引女使" then
		if 事件=="是的我要去" then
		  地图处理类:npc传送(数字id,1001,470,253)
		end
	elseif 名称=="柳飞絮" then
		if 事件=="购买暗器" then
		 	玩家数据[数字id].商品列表=商店处理类.商品列表[47]
			发送数据(id,9,{商品=商店处理类.商品列表[47],银子=玩家数据[数字id].角色.银子})
		end
	end
end
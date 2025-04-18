-- @Author: baidwwy
-- @Date:   2024-05-23 06:02:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-06-06 12:04:08
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:33:57
-- @最后修改来自: baidwwy
-- @Last Modified time: 2024-04-08 23:01:42
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1216]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	玩家数据[数字id].转换坐骑=nil
	玩家数据[数字id].zuoqixuanze=nil
	玩家数据[数字id].zuoqixuanze1=nil

	if 编号 == 1 then
		wb[1] = "异兽录上记载了各式神怪之物的修炼之道，不知少侠可有耳闻？小仙受玉帝所托，将此道传授给有缘之人。"
		local xx = {"了解召唤兽进阶","我要帮召唤兽提升能力","我先告退"}
		return{"进阶凤凰","御兽仙",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 2 then
		wb[1] = "如今坐骑天下，人人坐骑代步也。"
		local xx = {"我要领取坐骑任务","我要来重置坐骑主属性","我要来转换坐骑造型","我来取消坐骑任务","我来兑换水晶糕","卸下玄灵珠","我点错了"}
		return{"大大王","百兽王",wb[取随机数(1,#wb)],xx}
	 elseif 编号 == 3 then
		wb[1] = "坐骑乃三界之灵，万兽之尊，本仙负责掌管桃源灵兽，你可以在我这里购买装饰品以及提升坐骑灵气的摄灵珠，每套装饰可以修炼八种境界，你可以随时来我这里提升装饰品境界，随着境界的提升召唤兽属性加成也会提升。坐骑灵气可以通过摄灵宝珠获得，当灵气达到一定程度可以提升坐骑的成长值，从而影响坐骑属性。"
		local xx = {"我来看看有啥好看的","我想了解坐骑装饰以及摄灵珠","我想购买增加灵气物品","","","查询坐骑灵气","我想修炼坐骑装饰的“境界”","我悄悄的走，不带走一片云彩。"}
		return{"南极仙翁","桃园仙翁",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[1216 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="御兽仙" then
		if 事件=="我要帮召唤兽提升能力" then
			if 玩家数据[数字id].角色.参战信息~=nil then
				local dh = "提升召唤兽能力需灵性达到110"
				local xx = {}
				local 认证码 = 玩家数据[数字id].角色.参战宝宝.认证码
				local 编号=玩家数据[数字id].召唤兽:取编号(认证码)
				if 玩家数据[数字id].召唤兽.数据[编号].进阶 and 玩家数据[数字id].召唤兽.数据[编号].进阶.灵性==110 then
				   dh = "苍天大地，小仙有生之年竟能再遇此等百年不遇的灵兽。来让小仙细细一看！多年前我曾机缘巧合掌握一秘法，可帮助灵兽脱胎换骨，寻觅多年现在终遇于此。你可以帮我找来#Y5个清灵仙露#W吗？我可以免费帮你提升该召唤兽的能力。"
				   xx[#xx+1] = 玩家数据[数字id].召唤兽.数据[编号].名称
				end
				发送数据(id,1501,{名称="御兽仙",模型="进阶凤凰",对话=dh,选项=xx})
			else
				添加最后对话(数字id,"请先将要提升的召唤兽参战")
			end
		elseif 事件=="了解召唤兽进阶" then
			添加最后对话(数字id,"少侠若要修炼你的召唤兽，使其进阶，需要满足以下条件:\n1）召唤兽参战等级≥45级或等级≥60级。\n2）召唤兽已学习内丹个数达到上限且低级内丹达到5层。\n3）满足了上述条件，就可以通过明暗雷战斗来让参战的召唤兽进入进阶之路。")
		else
			if 事件~="我先告退" then
				if 玩家数据[数字id].角色.参战信息~=nil then
					if 玩家数据[数字id].角色.参战宝宝.名称==事件 then
						local 认证码 = 玩家数据[数字id].角色.参战宝宝.认证码
						local 编号=玩家数据[数字id].召唤兽:取编号(认证码)
						发送数据(id,109,{宝宝=玩家数据[数字id].召唤兽.数据[编号]})
					else
						添加最后对话(数字id,"提升召唤兽能力需灵性达到110")
					end
				end
			end
		end
	elseif 名称=="百兽王" then
		if 事件=="我要领取坐骑任务" then
			添加最后对话(数字id,"正在开发，敬请期待")
		elseif 事件=="我要来重置坐骑主属性" then
			if 玩家数据[数字id].角色.坐骑==nil then
				添加最后对话(数字id,"不要为难老夫，您都没有坐骑，何来重置一说？（请骑乘想要重置的坐骑）")
				return
			end
			玩家数据[数字id].转换坐骑={编号=玩家数据[数字id].角色:取坐骑编号(玩家数据[数字id].角色.坐骑.认证码),类型="属性"}
			添加最后对话(数字id,"你可以支付288W两银子来为你的坐骑#Y"..玩家数据[数字id].角色.坐骑.名称.."#W进行属性重置",{"确定重置坐骑属性","我点错了"})
		elseif 事件=="我要来转换坐骑造型" then
			if 玩家数据[数字id].角色.坐骑==nil then
				添加最后对话(数字id,"不要为难老夫，您都没有坐骑，何来转换一说？（请骑乘想要转换的坐骑）")
				return
			end
			local xx=全局坐骑资料:取可转换坐骑(玩家数据[数字id].角色.模型,玩家数据[数字id].角色.种族)
			xx[#xx+1]="我点错了"
			玩家数据[数字id].转换坐骑={编号=玩家数据[数字id].角色:取坐骑编号(玩家数据[数字id].角色.坐骑.认证码),类型="造型"}
			添加最后对话(数字id,"想要改变坐骑造型本王要收点小钱钱买点小酒，八八发，就收你88万两吧。（根据种族来判断可转换的坐骑造型）目前你骑乘的坐骑#Y"..玩家数据[数字id].角色.坐骑.名称.."#W。可以进行以下造型转换：",xx)
		elseif 事件=="我来取消坐骑任务" then
			添加最后对话(数字id,"正在开发，敬请期待")
		elseif 事件=="我来兑换水晶糕" then
			添加最后对话(数字id,"正在开发，敬请期待")
		---------------------------
		elseif 事件=="卸下玄灵珠" then
			if 玩家数据[数字id].角色.玄灵珠==nil then
				 玩家数据[数字id].角色.玄灵珠={类型="回春",破军=0,回春=0,空灵=0,噬魂=0}
			end
		    添加最后对话(数字id,"请选择要卸下的玄灵珠",{"卸下玄灵珠·回春","卸下玄灵珠·破军","卸下玄灵珠·空灵","卸下玄灵珠·噬魂"})
		elseif 事件=="卸下玄灵珠·回春" then
			if 玩家数据[数字id].角色.玄灵珠.回春 <= 0 then
				常规提示(数字id,"#Y/玄灵珠·回春0级无法卸载")
			else
			    玩家数据[数字id].道具:给予道具(数字id,"玄灵珠·回春",nil,玩家数据[数字id].角色.玄灵珠.回春,"不存共享")
			    玩家数据[数字id].角色.玄灵珠.回春 = 0
			    发送数据(玩家数据[数字id].连接id,207,玩家数据[数字id].角色.玄灵珠)
			    常规提示(数字id,"#Y/卸下玄灵珠·回春成功")
			end
		elseif 事件=="卸下玄灵珠·破军" then
			if 玩家数据[数字id].角色.玄灵珠.破军 <= 0 then
				常规提示(数字id,"#Y/玄灵珠·破军0级无法卸载")
			else
			    玩家数据[数字id].道具:给予道具(数字id,"玄灵珠·破军",nil,玩家数据[数字id].角色.玄灵珠.破军,"不存共享")
			    玩家数据[数字id].角色.玄灵珠.破军 = 0
			    发送数据(玩家数据[数字id].连接id,207,玩家数据[数字id].角色.玄灵珠)
			    常规提示(数字id,"#Y/卸下玄灵珠·破军成功")
			end
		elseif 事件=="卸下玄灵珠·空灵" then
			if 玩家数据[数字id].角色.玄灵珠.空灵 <= 0 then
				常规提示(数字id,"#Y/玄灵珠·空灵0级无法卸载")
			else
			    玩家数据[数字id].道具:给予道具(数字id,"玄灵珠·空灵",nil,玩家数据[数字id].角色.玄灵珠.空灵,"不存共享")
			    玩家数据[数字id].角色.玄灵珠.空灵 = 0
			    发送数据(玩家数据[数字id].连接id,207,玩家数据[数字id].角色.玄灵珠)
			    常规提示(数字id,"#Y/卸下玄灵珠·空灵成功")
			end
		elseif 事件=="卸下玄灵珠·噬魂" then
			if 玩家数据[数字id].角色.玄灵珠.噬魂 <= 0 then
				常规提示(数字id,"#Y/玄灵珠·噬魂0级无法卸载")
			else
			    玩家数据[数字id].道具:给予道具(数字id,"玄灵珠·噬魂",nil,玩家数据[数字id].角色.玄灵珠.噬魂,"不存共享")
			    玩家数据[数字id].角色.玄灵珠.噬魂 = 0
			    发送数据(玩家数据[数字id].连接id,207,玩家数据[数字id].角色.玄灵珠)
			    常规提示(数字id,"#Y/卸下玄灵珠·空灵成功")
			end
		---------------------------
		else
			if 事件~="我点错了" then
				if 玩家数据[数字id].角色.坐骑==nil then
					return
				end
				if 玩家数据[数字id].转换坐骑 then
					local bh=玩家数据[数字id].转换坐骑.编号
					if bh==nil or 玩家数据[数字id].角色.坐骑列表[bh]==nil then
						添加最后对话(数字id,"未检测到坐骑！")
						return
					end
					if 玩家数据[数字id].转换坐骑.类型=="造型" then
						local xx=全局坐骑资料:取可转换坐骑(玩家数据[数字id].角色.模型,玩家数据[数字id].角色.种族)
						for i=1,#xx do
							if 事件==xx[i] then
								if 玩家数据[数字id].角色:扣除银子(880000,0,0,"坐骑造型",1) then
									玩家数据[数字id].角色.坐骑列表[bh].模型=事件
									if 玩家数据[数字id].角色.坐骑列表[bh].饰品 and 玩家数据[数字id].角色.坐骑列表[bh].饰品.名称 then --转换坐骑装饰
										-- local swqe=玩家数据[数字id].角色.坐骑列表[bh].饰品
										-- local xys=取坐骑装饰分类(事件)
										-- swqe.名称=xys.mc
										-- swqe.分类=xys.fl
										-- swqe.子类=xys.zl
										-- 玩家数据[数字id].角色.坐骑列表[bh].饰品=swqe
										-- 发送数据(id,62,{编号=bh,坐骑数据=玩家数据[数字id].角色.坐骑列表[bh]}) --有问题后续更新
									end
									玩家数据[数字id].角色.坐骑列表[bh].炫彩=nil
									玩家数据[数字id].角色.坐骑列表[bh].炫彩组=nil
									玩家数据[数字id].角色.坐骑列表[bh].染色组=0
									发送数据(id, 61, 玩家数据[数字id].角色.坐骑列表)
									玩家数据[数字id].角色.坐骑=nil
									玩家数据[数字id].角色:刷新信息("33")
									发送数据(id,60,nil)
									地图处理类:更新坐骑(数字id,nil)
									常规提示(数字id,"坐骑转换成功！")
								end
								return
							end
						end
					elseif 玩家数据[数字id].转换坐骑.类型=="属性" then
						if 事件=="确定重置坐骑属性" then
							if 玩家数据[数字id].角色:扣除银子(2880000,0,0,"坐骑造型",1) then
								玩家数据[数字id].角色.坐骑列表[bh].主属性=nil
								常规提示(数字id,"重置坐骑属性成功")
								发送数据(id,61,玩家数据[数字id].角色.坐骑列表)
							end
						end
					end
				end
			end
		end
	elseif 名称=="桃园仙翁" then
		-- {"我来看看有啥好看的","我想了解坐骑装饰以及摄灵珠","我想购买增加灵气物品","","","我想修炼坐骑装饰的“境界”","查询坐骑灵气","我悄悄的走，不带走一片云彩。"}
		if 事件=="我想了解坐骑装饰以及摄灵珠" then
			添加最后对话(数字id,"坐骑乃三界之灵，万兽之尊，每个坐骑拥有初始造型，通过购买装饰品可以给坐骑更换装饰，每只坐骑有三套装饰品可以用于更换，每套装饰可以修炼八种境界，通过提升装饰品“境界”可以增加装饰品对召唤兽的属性加成。摄灵珠可以提升坐骑灵气，当灵气达到一定程度可以提升坐骑的成长值，从而影响坐骑对人物角色的属性加成。")
		elseif 事件=="我想购买增加灵气物品" then
			添加最后对话(数字id,"摄灵珠可以给坐骑增加坐骑的灵气，当灵气累计到一定程度就可以增加坐骑的成长值。每只坐骑每天最多可以喂食100次摄灵珠(开服时间≥360天的服务器没有此限制)，喂食时有几率出现提升双倍灵气效果。",{"4灵气：16000两","20灵气：80000两","100灵气：400000两","500灵气：2000000两"})
		elseif 事件=="4灵气：16000两" then
			if 玩家数据[数字id].角色:扣除银子(16000,0,0,"桃园仙翁",1) then
				玩家数据[数字id].道具:给予道具(数字id,"高级摄灵珠",nil,4)
			end
		elseif 事件=="20灵气：80000两" then
			if 玩家数据[数字id].角色:扣除银子(80000,0,0,"桃园仙翁",1) then
				玩家数据[数字id].道具:给予道具(数字id,"高级摄灵珠",nil,20)
			end
		elseif 事件=="100灵气：400000两" then
			if 玩家数据[数字id].角色:扣除银子(400000,0,0,"桃园仙翁",1) then
				玩家数据[数字id].道具:给予道具(数字id,"高级摄灵珠",nil,100)
			end
		elseif 事件=="500灵气：2000000两" then
			if 玩家数据[数字id].角色:扣除银子(2000000,0,0,"桃园仙翁",1) then
				玩家数据[数字id].道具:给予道具(数字id,"高级摄灵珠",nil,500)
			end
		elseif 事件=="查询坐骑灵气" then
			local xx={}
			for k,v in pairs(玩家数据[数字id].角色.坐骑列表) do
				xx[k]=v.名称
				玩家数据[数字id].zuoqixuanze={}
				玩家数据[数字id].zuoqixuanze[名称]={rzm=v.认证码,mc=v.名称}
			end
			xx[#xx+1]="取消"
			添加最后对话(数字id,"少侠要查询哪只坐骑呢",xx)
		elseif 玩家数据[数字id].zuoqixuanze and 事件==玩家数据[数字id].zuoqixuanze[名称] then
			local 编号=玩家数据[数字id].角色:取坐骑编号(玩家数据[数字id].zuoqixuanze[名称].rzm)
			玩家数据[数字id].zuoqixuanze=nil
			if 编号~=0 then
				if 玩家数据[数字id].角色.坐骑列表[编号].SLZ then
					local cs=玩家数据[数字id].角色.坐骑列表[编号].SLZ.次数
					添加最后对话(数字id,玩家数据[数字id].角色.坐骑列表[编号].名称.."的灵气为"..玩家数据[数字id].角色.坐骑列表[编号].SLZ.灵气.."，今日这只坐骑还可以喂食"..cs.."个摄灵珠。")
				else
					添加最后对话(数字id,玩家数据[数字id].角色.坐骑列表[编号].名称.."的灵气为0，今日这只坐骑还可以喂食100个摄灵珠。")
				end
			end
		end
	end
end

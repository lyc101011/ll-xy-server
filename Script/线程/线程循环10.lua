-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-05-10 22:34:27
-- @最后修改来自: baidwwy
-- @Last Modified time: 2024-04-04 19:27:35
local ffi = require("ffi")
状态 = "等待启动"
local k = 1
function 循环函数()
	--返回消息("循环")
	k = k+1
	if 状态 == "等待启动" then
		local 指针 = 返回消息("取数量指针")--获取共享内存指针
		数量指针 = ffi.cast("int*",指针)
	    状态 = "启动中"
	    返回消息("线程启动中")
	elseif 状态 == "启动中" then
		if 数量指针[0] > 0 then--向主线程拉数据
		    等到数据 = {返回消息("取数据")}
		    数量指针[0] = 数量指针[0] -1
		end
	end
end

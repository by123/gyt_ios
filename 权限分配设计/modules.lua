
-- 将lua中的table转换为json
local function table2json(t)
	local function serialize(tbl)
	local tmp = {}
		for k, v in pairs(tbl) do
            local k_type = type(k)
            local v_type = type(v)
            local key = (k_type == "string" and "\"" .. k .. "\":")
                or (k_type == "number" and "")
            local value = (v_type == "table" and serialize(v))
                or (v_type == "boolean" and tostring(v))
                or (v_type == "string" and "\"" .. v .. "\"")
                or (v_type == "number" and v)
            tmp[#tmp + 1] = key and value and tostring(key) .. tostring(value) or nil
            --tmp[#tmp + 1] = key and tostring(key) .. (value and tostring(value) or nil)
        end
		if table.maxn(tbl) == 0 then
            return "{" .. table.concat(tmp, ",") .. "}"
        else
            return "[" .. table.concat(tmp, ",") .. "]"
        end
    end
    assert(type(t) == "table")
    return serialize(t)
end

g_modules_supperAdmin = {                        --超级管理员
	mdl_auth = {
		--路由管理
		mdl_authority_rout_add = 1;                       --添加路由
		mdl_authority_rout_edit = 1;                      --编辑路由
		mdl_authority_rout_delete = 1;                    --删除路由
		mdl_authority_rout_query = 1;                     --查询路由
		
		--柜台账户
		mdl_authority_add_user = 1;                     --添加柜员
		mdl_authority_edit_user = 1;                    --编辑柜员  
		mdl_authority_frozen_user = 1;                  --冻结柜员 
		mdl_authority_delete_user = 1;                  --删除柜员 
		mdl_authority_query_user = 1;                   --查询柜员 
		mdl_authority_customer_flow = 1;                --客户流水 
		mdl_authority_capitial_flow = 1;                --资金流水
		mdl_authority_route_bind = 1;	                --路由绑定
		mdl_authority_user_withdrawal = 1;              --体现申请
		
		--通道管理
		mdl_authority_broker_add = 1;                     --添加通道
		mdl_authority_broker_del = 1;                     --删除通道
		mdl_authority_broker_edit = 1;                    --编辑通道
		mdl_authority_broker_query = 1;                   --查询通道
		
		--汇率设置
		mdl_authority_add_exchange_rate = 1;              --添加汇率
		mdl_authority_del_exchange_rate = 1;              --删除汇率
		mdl_authority_edit_exchange_rate = 1;             --编辑汇率
		mdl_authority_query_exchange_rate = 1;            --查询汇率
		
		--资金审核     
		mdl_authority_check_in_cash = 1;		          --入金审核
		mdl_authority_check_out_cash = 1;                 --出金审核
		
		--留痕日志
		mdl_authority_mark_log = 1;                       --留痕日志
		
		--权限分配
		mdl_authority_edit_lowwer_authority = 1;          --修改下级权限
		
		--我的信息
		mdl_authority_edit_user_base_info = 1;            --编辑本级信息
		
		--账号管理     
		mdl_authority_add_account = 1;			          --添加账号
		mdl_authority_del_account = 1;			          --删除账号
		mdl_authority_edit_account = 1;			          --编辑账号
		mdl_authority_query_account = 1;	              --查询账号   
		mdl_authority_summit_in_cash = 1;                 --入金申请 
		mdl_authority_summit_out_cash = 1;                --出金申请 
		mdl_authority_order_operation = 1;                --交易面板 
		mdl_authority_panel_position = 1;                 --持仓查询
		mdl_authority_panel_order = 1;                    --委托查询
		mdl_authority_panel_deal = 1;                     --成交查询
		mdl_authority_panel_history = 1;                  --历史数据查询
		mdl_authority_account_force_close = 1;  		  --强平
		mdl_authority_account_active = 1;                 --激活
		mdl_authority_account_frozen = 1;                 --冻结
		
		--配置信息
		mdl_authority_priority_config = 1;                --优先配置
		mdl_authority_priority_rate_charge = 1;           --优先利率收取
		mdl_authority_priority_origin_ini = 1;            --初始劣后
		mdl_authority_priority_force_cover = 1;           --强平线
		mdl_authority_priority_reset_ini = 1;             --重置劣后
		
		--数据统计
		mdl_authority_statics = 1;		                  --数据统计
		
		--费率管理
		mdl_authority_add_template = 1;                   --添加模版
		mdl_authority_del_template = 1;          		  --删除模版
		mdl_authority_edit_template = 1;        		  --编辑模版
		mdl_authority_query_template = 1;		          --查询模版
		
		--交易控制
		mdl_authority_slippage_manager = 1;				  --滑点管理
		mdl_authority_investment_manager = 1;			  --跟投管理
		mdl_authority_sample_manager = 1;				  --样本管理
		mdl_authority_sample_distributuin = 1;			  --样本分配
	}
}

g_modules_ProxyCompany = {                  --代理公司
	mdl_auth = {		
		--柜台账户
		mdl_authority_add_user = 1;                     --添加柜员
		mdl_authority_edit_user = 1;                    --编辑柜员  
		mdl_authority_frozen_user = 1;                  --冻结柜员 
		mdl_authority_delete_user = 1;                  --删除柜员 
		mdl_authority_query_user = 1;                   --查询柜员 
		mdl_authority_customer_flow = 1;                --客户流水 
		mdl_authority_capitial_flow = 1;                --资金流水
		mdl_authority_route_bind = 1;	                --路由绑定
		mdl_authority_user_withdrawal = 1;              --体现申请
		
		--汇率设置
		mdl_authority_add_exchange_rate = 1;              --添加汇率
		mdl_authority_del_exchange_rate = 1;              --删除汇率
		mdl_authority_edit_exchange_rate = 1;             --编辑汇率
		mdl_authority_query_exchange_rate = 1;            --查询汇率
		
		--资金审核     
		mdl_authority_check_in_cash = 1;		          --入金审核
		mdl_authority_check_out_cash = 1;                 --出金审核
		
		--留痕日志
		mdl_authority_mark_log = 1;                       --留痕日志
		
		--权限分配
		mdl_authority_edit_lowwer_authority = 1;          --修改下级权限
		
		--我的信息
		mdl_authority_edit_user_base_info = 1;            --编辑本级信息
		
		--账号管理     
		mdl_authority_add_account = 1;			          --添加账号
		mdl_authority_del_account = 1;			          --删除账号
		mdl_authority_edit_account = 1;			          --编辑账号
		mdl_authority_query_account = 1;	              --查询账号   
		mdl_authority_summit_in_cash = 1;                 --入金申请 
		mdl_authority_summit_out_cash = 1;                --出金申请 
		mdl_authority_order_operation = 1;                --交易面板 
		mdl_authority_panel_position = 1;                 --持仓查询
		mdl_authority_panel_order = 1;                    --委托查询
		mdl_authority_panel_deal = 1;                     --成交查询
		mdl_authority_panel_history = 1;                  --历史数据查询
		mdl_authority_account_force_close = 1;  		  --强平
		mdl_authority_account_active = 1;                 --激活
		mdl_authority_account_frozen = 1;                 --冻结
		
		--配置信息
		mdl_authority_priority_config = 1;                --优先配置
		mdl_authority_priority_rate_charge = 1;           --优先利率收取
		mdl_authority_priority_origin_ini = 1;            --初始劣后
		mdl_authority_priority_force_cover = 1;           --强平线
		mdl_authority_priority_reset_ini = 1;             --重置劣后
		
		--数据统计
		mdl_authority_statics = 1;		                  --数据统计
		
		--费率管理
		mdl_authority_add_template = 1;                   --添加模版
		mdl_authority_del_template = 1;          		  --删除模版
		mdl_authority_edit_template = 1;        		  --编辑模版
		mdl_authority_query_template = 1;		          --查询模版
	}  
}

g_modules_Proxy = {                    -- 个人代理
	mdl_auth = {		
		--柜台账户
		mdl_authority_add_user = 1;                     --添加柜员
		mdl_authority_edit_user = 1;                    --编辑柜员  
		mdl_authority_frozen_user = 1;                  --冻结柜员
		mdl_authority_query_user = 1;                   --查询柜员 
		mdl_authority_customer_flow = 1;                --客户流水 
		mdl_authority_capitial_flow = 1;                --资金流水
		mdl_authority_route_bind = 1;	                --路由绑定
		mdl_authority_user_withdrawal = 1;              --体现申请
		
		--留痕日志
		mdl_authority_mark_log = 1;                       --留痕日志
		
		--权限分配
		mdl_authority_edit_lowwer_authority = 1;          --修改下级权限
		
		--我的信息
		mdl_authority_edit_user_base_info = 1;            --编辑本级信息
		
		--账号管理     
		mdl_authority_add_account = 1;			          --添加账号
		mdl_authority_edit_account = 1;			          --编辑账号
		mdl_authority_query_account = 1;	              --查询账号   
		mdl_authority_summit_in_cash = 1;                 --入金申请 
		mdl_authority_summit_out_cash = 1;                --出金申请
		mdl_authority_panel_position = 1;                 --持仓查询
		mdl_authority_panel_order = 1;                    --委托查询
		mdl_authority_panel_deal = 1;                     --成交查询
		mdl_authority_panel_history = 1;                  --历史数据查询
		mdl_authority_account_active = 1;                 --激活
		mdl_authority_account_frozen = 1;                 --冻结
		
		--配置信息
		mdl_authority_priority_config = 1;                --优先配置
		mdl_authority_priority_rate_charge = 1;           --优先利率收取
		mdl_authority_priority_origin_ini = 1;            --初始劣后
		mdl_authority_priority_force_cover = 1;           --强平线
		
		--数据统计
		mdl_authority_statics = 1;		                  --数据统计
		
		--费率管理
		mdl_authority_add_template = 1;                   --添加模版
		mdl_authority_del_template = 1;          		  --删除模版
		mdl_authority_edit_template = 1;        		  --编辑模版
		mdl_authority_query_template = 1;		          --查询模版
	}
}

g_modules_RiskContorller = {          -- 风控
	mdl_auth = {
		--路由管理
		mdl_authority_rout_add = 1;                       --添加路由
		mdl_authority_rout_edit = 1;                      --编辑路由
		mdl_authority_rout_delete = 1;                    --删除路由
		mdl_authority_rout_query = 1;                     --查询路由
		
		--通道管理
		mdl_authority_broker_add = 1;                     --添加通道
		mdl_authority_broker_del = 1;                     --删除通道
		mdl_authority_broker_edit = 1;                    --编辑通道
		mdl_authority_broker_query = 1;                   --查询通道
		
		--汇率设置
		mdl_authority_add_exchange_rate = 1;              --添加汇率
		mdl_authority_del_exchange_rate = 1;              --删除汇率
		mdl_authority_edit_exchange_rate = 1;             --编辑汇率
		mdl_authority_query_exchange_rate = 1;            --查询汇率
		
		--留痕日志
		mdl_authority_mark_log = 1;                       --留痕日志
		
		--我的信息
		mdl_authority_edit_user_base_info = 1;            --编辑本级信息
		
		--账号管理     
		mdl_authority_order_operation = 1;                --交易面板 
		mdl_authority_panel_position = 1;                 --持仓查询
		mdl_authority_panel_order = 1;                    --委托查询
		mdl_authority_panel_deal = 1;                     --成交查询
		mdl_authority_panel_history = 1;                  --历史数据查询
		mdl_authority_account_force_close = 1;  		  --强平
		mdl_authority_account_active = 1;                 --激活
		mdl_authority_account_frozen = 1;                 --冻结
		
		--配置信息
		mdl_authority_priority_config = 1;                --优先配置
		mdl_authority_priority_rate_charge = 1;           --优先利率收取
		mdl_authority_priority_origin_ini = 1;            --初始劣后
		mdl_authority_priority_force_cover = 1;           --强平线
		mdl_authority_priority_reset_ini = 1;             --重置劣后
		
		--数据统计
		mdl_authority_statics = 1;		                  --数据统计
		
		--费率管理
		mdl_authority_add_template = 1;                   --添加模版
		mdl_authority_del_template = 1;          		  --删除模版
		mdl_authority_edit_template = 1;        		  --编辑模版
		mdl_authority_query_template = 1;		          --查询模版
		
		--交易控制
		mdl_authority_slippage_manager = 1;				  --滑点管理
		mdl_authority_investment_manager = 1;			  --跟投管理
		mdl_authority_sample_manager = 1;				  --样本管理
		mdl_authority_sample_distributuin = 1;			  --样本分配
	}
}

g_modules_Finance = {              --财务
	mdl_auth = {		
		--资金审核     
		mdl_authority_check_in_cash = 1;		          --入金审核
		mdl_authority_check_out_cash = 1;                 --出金审核
		
		--我的信息
		mdl_authority_edit_user_base_info = 1;            --编辑本级信息
		
		--账号管理     
		mdl_authority_edit_account = 1;			          --编辑账号
		mdl_authority_query_account = 1;	              --查询账号
		mdl_authority_order_operation = 1;                --交易面板 
		mdl_authority_panel_position = 1;                 --持仓查询
		mdl_authority_panel_order = 1;                    --委托查询
		mdl_authority_panel_deal = 1;                     --成交查询
		mdl_authority_panel_history = 1;                  --历史数据查询
		mdl_authority_account_force_close = 1;  		  --强平
		
		--配置信息
		mdl_authority_priority_config = 1;                --优先配置
		mdl_authority_priority_rate_charge = 1;           --优先利率收取
		mdl_authority_priority_origin_ini = 1;            --初始劣后
		mdl_authority_priority_force_cover = 1;           --强平线
		mdl_authority_priority_reset_ini = 1;             --重置劣后
		
		--数据统计
		mdl_authority_statics = 1;		                  --数据统计
	}
}

function getModules(userType)
    if userType == "1" then
	    return table2json(g_modules_supperAdmin)
	elseif userType == "2" then
	    return table2json(g_modules_ProxyCompany)
	elseif userType == "3" then
	    return table2json(g_modules_Proxy)
	elseif userType == "4" then
	    return table2json(g_modules_Finance)
	elseif userType == "5" then
	    return table2json(g_modules_RiskContorller)
    end	
end


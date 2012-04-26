/********************************************************************
Author: Thomas Stringer
Created on: 4/26/2012

Description:
	the below code creates a condition, policy, and dependent data 
	to generate a policy to check AutoClose property on databases to 
	be OFF

Notes:
	- this is for non-system dbs

	- it creates it as ON DEMAND evaluation mode (alter as necessary) 
********************************************************************/

-- first create the condition
declare @condition_id int

exec msdb.dbo.sp_syspolicy_add_condition 
	@name = N'AutoCloseOff', 
	@description = N'', 
	@facet = N'Database', 
	@expression = N'
		<Operator>
		  <TypeClass>Bool</TypeClass>
		  <OpType>EQ</OpType>
		  <Count>2</Count>
		  <Attribute>
			<TypeClass>Bool</TypeClass>
			<Name>AutoClose</Name>
		  </Attribute>
		  <Function>
			<TypeClass>Bool</TypeClass>
			<FunctionType>False</FunctionType>
			<ReturnType>Bool</ReturnType>
			<Count>0</Count>
		  </Function>
		</Operator>', 
	@is_name_condition = 0, 
	@obj_name = N'', 
	@condition_id = @condition_id output

select @condition_id

go


-- next create the policy and dependent attributes
declare @object_set_id int
exec msdb.dbo.sp_syspolicy_add_object_set 
	@object_set_name = N'AutoCloseOff_ObjectSet', 
	@facet = N'Database', 
	@object_set_id = @object_set_id output
select @object_set_id

declare @target_set_id int
exec msdb.dbo.sp_syspolicy_add_target_set 
	@object_set_name = N'AutoCloseOff_ObjectSet', 
	@type_skeleton = N'Server/Database', 
	@type = N'DATABASE', 
	@enabled = 1, 
	@target_set_id = @target_set_id output
select @target_set_id

exec msdb.dbo.sp_syspolicy_add_target_set_level 
	@target_set_id = @target_set_id, 
	@type_skeleton = N'Server/Database', 
	@level_name = N'Database', 
	@condition_name = N'', 
	@target_set_level_id = 0
go

declare @policy_id int
exec msdb.dbo.sp_syspolicy_add_policy 
	@name = N'AutoCloseOff', 
	@condition_name = N'AutoCloseOff', 
	@policy_category = N'', 
	@execution_mode = 0, 
	@policy_id = @policy_id output, 
	@root_condition_name = N'', 
	@object_set = N'AutoCloseOff_ObjectSet'
select @policy_id
go


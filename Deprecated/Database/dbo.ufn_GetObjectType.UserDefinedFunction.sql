/****** Object:  UserDefinedFunction [dbo].[ufn_GetObjectType]    Script Date: 07/09/2008 12:08:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_GetObjectType]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ufn_GetObjectType] (@xml_data xml)
RETURNS TABLE
AS
RETURN 
(
	SELECT CONVERT(varchar(max),@xml_data) AS objects, objects.objecttype.value(''.'', ''nvarchar(100)'') As ObjectType
	FROM @xml_data.nodes(''/Object/@ObjectType'')  objects(objecttype)
);' 
END
GO

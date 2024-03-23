CREATE FUNCTION dbo.PascalToCamelCase (@input NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
  DECLARE @length INT = LEN(@input)

  IF @length = 0
      RETURN @input

  IF @length = 1
      RETURN LOWER(@input)

  DECLARE @output NVARCHAR(MAX) = LOWER(SUBSTRING(@input, 1, 1)) + SUBSTRING(@input, 2, @length - 1)

  RETURN @output
END
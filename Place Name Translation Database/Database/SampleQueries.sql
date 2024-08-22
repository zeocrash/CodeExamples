--Find all translated place names for a like match
;with cte_searchedPlace as(
SELECT [trns_lng_ID]
      ,[trns_plc_ID]
      ,[trns_NameTranslation]
  FROM [TranslationTest].[dbo].[T_Translations]
  where [trns_NameTranslation] like 'hoqcicz%' --Change this to be part of one of the place names (place names are randomly geneerated so what works for me won't work for you
  )
  SELECT TRN.*
FROM [TranslationTest].[dbo].[T_Translations] TRN
INNER JOIN cte_searchedPlace SP ON TRN.trns_plc_ID = SP.trns_plc_ID


-- Find the top 1000 place names in "armenian"

SELECT TOP (1000) [lng_ID]
      ,[lng_Name]
      ,[lng_Code]
  FROM [TranslationTest].[dbo].[T_Language] lng
  inner join [dbo].[T_Translations] trn on trn.trns_lng_ID = lng.lng_ID
  where lng.lng_Code = 'hy'

  --Exact match on a place name 

  SELECT *
  FROM [TranslationTest].[dbo].[T_Translations]
  where [trns_NameTranslation] = 'hoqciczvzserwjnazjaeptvryqrcdkmwocxowrszkdniflwsamlbpjqdqrvtpqqayssqqmdlqkigbuuokkukdapxijhwoqnmkhpulgoofpt'
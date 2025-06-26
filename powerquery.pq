// powerquery.pq
let
    Source = Csv.Document(
        File.Contents("C:/path/to/finance-dashboard/data/Finance_data.csv"),
        [Delimiter=",", Columns=31, Encoding=1252, QuoteStyle=QuoteStyle.None]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedTypes = Table.TransformColumnTypes(PromotedHeaders,{
        {"gender", type text}, {"age", Int64.Type},
        // Add all other column type definitions
    }),
    
    // Add your transformations here
    AddAgeGroup = Table.AddColumn(ChangedTypes, "Age Group", each 
        if [age] <= 25 then "20-25"
        else if [age] <= 30 then "26-30"
        else "31-35", type text)
in
    AddAgeGroup
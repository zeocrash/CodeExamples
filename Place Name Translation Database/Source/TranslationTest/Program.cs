using System.Data;
using Bogus;
using Microsoft.Data.SqlClient;

namespace TranslationTest
{
    internal class Program
    {
        //https://www.reddit.com/r/dotnet/comments/1exrp0u/how_to_store_data_in_net_add_with_sql_server_in/
        private const string connString =
            @"Connection String Goes here";
        static void Main(string[] args)
        {
            var placeNameGenerator = new Faker();
            const int totalPlaces = 660702; //Sum total of places specified in Reddit post




            var conn = new SqlConnection(connString);

            Console.WriteLine("Adding Place table data");
            //Technically a places table is unneccesary but oh well
            InsertPlaces(conn, totalPlaces, placeNameGenerator);
            Console.WriteLine("Place Table Data COmplete");

            Console.WriteLine("Adding Translations");
            InsertTranslations(conn, totalPlaces, placeNameGenerator);


            Console.WriteLine($"TranslationsComplete");
            Console.ReadLine();
        }

        private static void InsertPlaces(SqlConnection conn, int totalPlaces, Faker placeNameGenerator)
        {
            for (int i = 0; i < totalPlaces; i++)
            {
                if (conn.State != ConnectionState.Open)
                    conn.Open();
                var cmdString = @$"INSERT INTO [dbo].[T_Places] ([plc_Name])
                VALUES ('{placeNameGenerator.Random.String2(5, 255)}')";
                var cmd = new SqlCommand(cmdString, conn);
                cmd.ExecuteNonQuery();
                if ((i % 1000) == 0)
                {
                    Console.WriteLine($"current Count {i}");
                }
            }
        }


        private static void InsertTranslations(SqlConnection conn, int totalPlaces, Faker placeNameGenerator)
        {

            // Yes i know this is a different way of inserting to the other function but the other one took forever so i decided to be less lazy and write something a bit better performing
            var bufferTable = new DataTable();
            DataColumn languageId = new DataColumn();
            languageId.DataType = System.Type.GetType("System.Int32");
            languageId.ColumnName = "trns_lng_ID";
            bufferTable.Columns.Add(languageId);

            DataColumn placeId = new DataColumn();
            placeId.DataType = System.Type.GetType("System.Int32");
            placeId.ColumnName = "trns_plc_ID";
            bufferTable.Columns.Add(placeId);

            DataColumn nameTranslation = new DataColumn();
            nameTranslation.DataType = System.Type.GetType("System.String");
            nameTranslation.ColumnName = "trns_NameTranslation";
            bufferTable.Columns.Add(nameTranslation);

            for (int i = 1; i <= 24; i++)
            {
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
                {
                    bulkCopy.DestinationTableName =
                        "[dbo].[T_Translations]";
                    for (int j = 1; j <= totalPlaces; j++)
                    {
                        DataRow row = bufferTable.NewRow();
                        row["trns_lng_ID"] = i;
                        row["trns_plc_ID"] = j;
                        row["trns_NameTranslation"] = placeNameGenerator.Random.String2(5, 255);
                        bufferTable.Rows.Add(row);
                        if ((j % 10000) == 0)
                        {
                            if (conn.State != ConnectionState.Open)
                                conn.Open();
                            bulkCopy.WriteToServer(bufferTable);
                            bufferTable.Clear();
                            Console.WriteLine($"Number of Rows copied {bulkCopy.RowsCopied}");
                        }


                    }

                    if (bufferTable.Rows.Count > 0)
                    {
                        if (conn.State != ConnectionState.Open)
                            conn.Open();
                        bulkCopy.WriteToServer(bufferTable);
                        bufferTable.Clear();
                        Console.WriteLine($"Number of Rows copied {bulkCopy.RowsCopied}");
                    }
                    Console.WriteLine($"Language Id {i} Complete");
                }

            }
        }
    }
}
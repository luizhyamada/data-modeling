from pyspark.sql import functions as F
from pyspark.sql.types import *

def air_cia():

    schema = StructType([
    StructField("company_name", StringType(), True),
    StructField("icao_iata_code", StringType(), True),
    StructField("tax_id", StringType(), True),
    StructField("air_operations", StringType(), True),
    StructField("headquarters_address", StringType(), True),
    StructField("phone_number", StringType(), True),
    StructField("email", StringType(), True),
    StructField("operational_status", StringType(), True),
    StructField("operational_status_date", StringType(), True),
    StructField("operational_valid_until", StringType(), True),
    ])

    df = (spark.read
            .option("header", "true")
            .option("delimiter", ";")
            .schema(schema)
            .csv("")
    )

    return (
        df
        .withColumn("_source_file", F.col("_metadata.file_path"))
        .withColumn("_ingestion_date", F.current_date())
        .withColumn("created_at", F.current_timestamp())
        .withColumn("updated_at", F.current_timestamp())
    )

df = air_cia()

(
    df.write
    .format("delta")
    .mode("append")
    .saveAsTable("bronze.air_cia")
)
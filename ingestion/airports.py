from pyspark.sql import functions as F

def airports():
    df = (
        spark.read
        .option("header", "true")
        .option("encoding", "latin1")
        .csv("")
    )

    df = df.toDF(*[
        c.lower().replace(" ", "_")
        for c in df.columns
    ])

    return (
        df
        .withColumn("_source_file", F.col("_metadata.file_path"))
        .withColumn("_ingestion_date", F.current_date())
        .withColumn("created_at", F.current_timestamp())
        .withColumn("updated_at", F.current_timestamp())
    )

df = airports()

(
    df.write
    .format("delta")
    .mode("append")
    .saveAsTable("bronze.airports")
)
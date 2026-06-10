from pyspark.sql import functions as F

def vra():
    df = (spark.read
            .json("")
    )   

    df = df.select(
    F.col("ChegadaPrevista").alias("scheduled_arrival"),
    F.col("ChegadaReal").alias("actual_arrival"),
    F.col("CódigoAutorização").alias("authorization_code"),
    F.col("CódigoJustificativa").alias("justification_code"),
    F.col("CódigoTipoLinha").alias("route_type_code"),
    F.col("ICAOAeródromoDestino").alias("destination_airport_icao"),
    F.col("ICAOAeródromoOrigem").alias("origin_airport_icao"),
    F.col("ICAOEmpresaAérea").alias("airline_icao_code"),
    F.col("NúmeroVoo").alias("flight_number"),
    F.col("PartidaPrevista").alias("scheduled_departure"),
    F.col("PartidaReal").alias("actual_departure"),
    F.col("SituaçãoVoo").alias("flight_status")
    )

    return (
        df
        .withColumn("_source_file", F.col("_metadata.file_path"))
        .withColumn("_ingestion_date", F.current_date())
        .withColumn("created_at", F.current_timestamp())
        .withColumn("updated_at", F.current_timestamp())
    )

df = vra()

(
    df.write
    .format("delta")
    .mode("append")
    .saveAsTable("bronze.vra")
)
{
  "preamble": {
    "title": "thomas/project",
    "description": "Aiken contracts for project 'thomas/project'",
    "version": "0.0.0",
    "plutusVersion": "v3",
    "compiler": {
      "name": "Aiken",
      "version": "v1.1.0+be31a7c"
    },
    "license": "Apache-2.0"
  },
  "validators": [
    {
      "title": "project.agritracechain.spend",
      "datum": {
        "title": "datum_otp",
        "schema": {
          "$ref": "#/definitions/project~1Datum"
        }
      },
      "redeemer": {
        "title": "_redeemer",
        "schema": {
          "$ref": "#/definitions/Data"
        }
      },
      "compiledCode": "58e201010032323232323225333002323232323253330073370e900118041baa0011323232533300a3370e900018059baa0011323232533300d3300137586004601e6ea8028dd7180898079baa00314a22660026eb0c008c03cdd50051bae30113012300f375400644646600200200644a66602600229404c94ccc044cdc79bae301500200414a2266006006002602a0024602060226022602260226022602260226022002601c60186ea800458c034c038008c030004c024dd50008b1805180580118048009804801180380098021baa00114984d9595cd2ab9d5573caae7d5d0aba201",
      "hash": "f2d4e95737b64423be22f9df931049a5017d03c7d4abc86fd315d293"
    },
    {
      "title": "project.agritracechain.else",
      "compiledCode": "58e201010032323232323225333002323232323253330073370e900118041baa0011323232533300a3370e900018059baa0011323232533300d3300137586004601e6ea8028dd7180898079baa00314a22660026eb0c008c03cdd50051bae30113012300f375400644646600200200644a66602600229404c94ccc044cdc79bae301500200414a2266006006002602a0024602060226022602260226022602260226022002601c60186ea800458c034c038008c030004c024dd50008b1805180580118048009804801180380098021baa00114984d9595cd2ab9d5573caae7d5d0aba201",
      "hash": "f2d4e95737b64423be22f9df931049a5017d03c7d4abc86fd315d293"
    }
  ],
  "definitions": {
    "Data": {
      "title": "Data",
      "description": "Any Plutus data."
    },
    "VerificationKeyHash": {
      "title": "VerificationKeyHash",
      "dataType": "bytes"
    },
    "project/Datum": {
      "title": "Datum",
      "anyOf": [
        {
          "title": "Datum",
          "dataType": "constructor",
          "index": 0,
          "fields": [
            {
              "title": "farmer",
              "$ref": "#/definitions/VerificationKeyHash"
            },
            {
              "title": "author",
              "$ref": "#/definitions/VerificationKeyHash"
            }
          ]
        }
      ]
    }
  }
}
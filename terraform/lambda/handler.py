def lambda_handler(event, context):
    san = event['san']
    # Convert SAN to FEN (stub implementation)
    fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
    return {
        'statusCode': 200,
        'body': fen
    }

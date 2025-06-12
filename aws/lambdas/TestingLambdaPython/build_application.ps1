#fsutil file createnew TestingLambdaPython/fake.bin 209715200
python -m pip install -r TestingLambdaPython/requirements.txt -t ./TestingLambdaPython
Compress-Archive -Path "./TestingLambdaPython/*" -DestinationPath TestingLambdaPython.zip
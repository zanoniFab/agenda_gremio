FROM public.ecr.aws/lambda/python:3.12

COPY infra/terraform/lambda/handler.py ${LAMBDA_TASK_ROOT}/handler.py

CMD ["handler.main"]

from django.conf import settings
from django.db import models

class Transfer(models.Model):
    customer = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, on_delete=models.SET_NULL)

    receiver_name = models.CharField(max_length=200, null=True)
    account_number = models.CharField(max_length=26, null=True)  # TODO
    title = models.CharField(max_length=200, null=True)
    amount = models.FloatField(null=True)  # TODO
    date_created = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        return self.title

class Comment(models.Model):
    matter = models.CharField(max_length=200, null=True)
    date_created = models.DateTimeField(auto_now=True, null=True)

    def __str__(self):
        return self.date_created
from django.forms import ModelForm
from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Transfer


class TransferForm(ModelForm):
    class Meta:
        model = Transfer
        fields = ['receiver_name', 'account_number', 'title', 'amount']


class CreateUserForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']

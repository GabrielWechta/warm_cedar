# Generated by Django 3.1.4 on 2020-12-24 12:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Transfer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('receiver_name', models.CharField(max_length=200, null=True)),
                ('account_number', models.CharField(max_length=26, null=True)),
                ('title', models.CharField(max_length=200, null=True)),
                ('amount', models.IntegerField(max_length=200, null=True)),
                ('date_created', models.DateTimeField(auto_now_add=True, null=True)),
            ],
        ),
    ]

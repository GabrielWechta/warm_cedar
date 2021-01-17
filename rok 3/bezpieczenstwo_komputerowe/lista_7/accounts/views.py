from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.utils.safestring import mark_safe

from .models import *
from .forms import TransferForm, CreateUserForm


def registerPage(request):
    form = CreateUserForm()
    if request.user.is_authenticated:
        return redirect('home')
    else:
        if request.method == "POST":
            form = CreateUserForm(request.POST)  # handles all
            if form.is_valid():
                form.save()
                messages.success(request, f"Account for {form.cleaned_data.get('username')} created.")
                return redirect('login')

        context = {'form': form}
        return render(request, 'accounts/register.html', context)


def loginPage(request):
    if request.user.is_authenticated:
        return redirect('home')
    else:
        if request.method == "POST":
            username = request.POST.get('username')
            password = request.POST.get('password')

            user = authenticate(request, username=username, password=password)

            if user is not None:
                login(request, user)
                return redirect('home')
            else:
                messages.info(request, 'Username or password is incorrect.')

        context = {}
        return render(request, 'accounts/login.html', context)


def logoutUser(request):
    logout(request)
    return redirect('login')


@login_required(login_url='login')
def home(request):
    if request.user.is_authenticated:
        username = request.user.username
    transfers = Transfer.objects.all()
    good_transfer = Transfer.objects.none()
    for t in transfers:
        try:
            if str(t.customer) == username:
                good_transfer |= Transfer.objects.filter(id=t.id)
        except Exception:
            pass

    number = good_transfer.count()

    context = {'number': number}
    return render(request, 'accounts/dashboard.html', context)


@login_required(login_url='login')
def products(request):
    username = None
    if request.user.is_authenticated:
        username = request.user.username
    transfers = Transfer.objects.all()
    good_transfer = Transfer.objects.none()
    for t in transfers:
        try:
            if str(t.customer) == username:
                good_transfer |= Transfer.objects.filter(id=t.id)
        except Exception:
            pass

    return render(request, 'accounts/products.html', {'transfers': good_transfer})


@login_required(login_url='login')
def createTransfer(request):
    form = TransferForm()
    if request.method == "POST":
        user = None
        if request.user.is_authenticated:
            user = request.user
            form = TransferForm(request.POST)
            # print(form.id)
            tmp = form.save(commit=False)
            tmp.customer = user
            tmp.save()
            context = {'post': request.POST}
            return render(request, 'accounts/transfer_confirm.html', context)

    context = {'form': form}
    return render(request, 'accounts/transfer_form.html', context)


@login_required(login_url='login')
def sendBackTransfer(request):
    print('inside!!!!!!!!!!!!!!!!!!')
    transfers = []
    for item in Transfer.objects.all():
        if item.customer_id == request.user.id:  # ?
            transfers.append(item)

    transfer = transfers[-1]

    context = {
        'post': transfer
    }
    return render(request, 'accounts/transfer_sent_back.html', context)


@login_required(login_url='login')
def hacks(request):
    return render(request, 'accounts/hacks.html')


@login_required(login_url='login')
def hacksSqlSearch(request):
    query = request.GET['q']
    customer_id = request.user.id
    # print(query)
    #
    # posts = Transfer.objects.raw(f"SELECT * FROM accounts_transfer WHERE receiver_name=\"{query}\" AND customer_id=\"{customer_id}\";")
    print(f"-- SELECT * FROM accounts_transfer WHERE receiver_name=\"{query}\" AND customer_id=\"{customer_id}\";")
    posts = Transfer.objects.raw(
        f"SELECT * FROM accounts_transfer WHERE receiver_name=\"{query}\" AND customer_id=\"{customer_id}\";")
    # print(posts)
    return render(request, 'accounts/hacks_sql_search.html', {'transfers': posts})


@login_required(login_url='login')
def hacksXss(request):
    add = request.GET['a']
    # customer_id = request.user.id
    comment = Comment(matter=mark_safe(add))
    print(comment.matter)
    comment.save()
    # print(add)
    # print(f"\"{add}\"")
    # # <script type="text/javascript">window.location.href = "http://localhost:8000/create_transfer/"</script>
    # context = {
    #     'class_name': 'large" style="font-size:4000px',
    #     # 'paragraph': mark_safe("<script type=\"text/javascript\">alert('hello wdwd world!');</script>"),
    #     'paragraph': mark_safe(add),
    # }

    return render(request, 'accounts/main.html')


@login_required(login_url='login')
def comments(request):
    my_comments = Comment.objects.all()

    return render(request, 'accounts/comments.html', {'comments': my_comments})

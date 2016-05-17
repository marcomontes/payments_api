## SETUP PROJECT

```
bundle install
```

## REQUIREMENTS

```
redis
```

## RUN TESTS

```
rspec
```


## API ROUTES

```
api/v1/tokens
```

Params:
```
{
name: "Marco Montes",
number: "4242 4242 4242 4242",
exp_month: "06",
exp_year: "2017",
cvc: "123"
}
```

---

```
api/v1/charges
```

Params:
```
{
  token_id: "tok_123123123123",
  amount: 10000,
  description: "My Test Card"
}
```

## CURL EXAMPLES

```
curl -H "Content-Type: application/json" -X POST -d '{ "name":"Marco Montes","number":"4242 4242 4242 4242","exp_month":"06","exp_year":"2017","cvc":"123" }' http://localhost:3000/api/v1/tokens
```

```
curl -H "Content-Type: application/json" -X POST -d '{ "token_id":"tok_7SegNb1i_RUQQvyJGDC5Zw","amount":"1000","description":"Test charge" }' http://localhost:3000/api/v1/charges
```


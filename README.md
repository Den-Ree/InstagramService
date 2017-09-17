# InstagramAPI
InstagramAPI is extension based on Alamofire, which is used to wrap InstagramResponces on Swift.

Before using of InstagramAPI you must include some libraries in your project

* [Alamofire](https://github.com/Alamofire/Alamofire)
* [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper)
* [AlamofireImage v3.1](https://github.com/Alamofire/AlamofireImage)
* [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)
* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)

# Features

* Authentificate in Instagram
* Create request
* Map JSON reponces

# Installation
There are two options of installing InstagramAPI on your machine or in your project, depending on preferens and needs:

* Download ZIP latest release
* Via CocoaPods

# Usage 

InstagramAPI provides you a network client based on Alamofire, which helps you to work with Instagram.

## Initialization of a client

There are two ways of initialization of a client

* When you don't have an access token
* When you have already got it

### Step 1 without authentication

If you have an access token, you can use client without authentication

    import InstagramService
    let client = InstagramClient.init("Your access_token", clientId: "Your client_id")
    
### Step 1 with authentication

When you don't have an accessToken, you have to go through an OAuth 2.0 provided by Instagram

Now you need to init your client

    import InstagramService
    let client = InstagramClient(clientId: "Your clientId", clientSecret: "Your clientSecret", clientRedirectUri: "Your clientRedirect_URL")


After initialization of a client, you must choose the type of authentication. There are two options:

* Via server side (When authenticationauthentication via server you will get a special code in responce, and after you have to send special link. Don't worry client support both options)
* Via client side (Here in responce you get an access token)
--- 
    import InstagramService
    // Server side
    let url = InstagramClient.InstagramAuthorisationUrl().serverSideFlow
    // Client side
    let url = InstagramClient.InstagramAuthorisationUrl().clientSideFlow

Now you have to create a webView, where you can authentificate your user, so you need to load your authentication Url into it. 
When you get some Url in responce, you have to load it to client. Client will write to the output field user information if it was success

    InstagramClient().receiveLoggedUser(responceUrl, completion: { (loggedUserId: String?, error: Error?) -> Void in
    })

The example of authentification you can find in [RootViewController.swift](https://github.com/Den-Ree/InstagramService/blob/master/src/InstagramAPI/InstagramAPI/Example/ViewControllers/Root/RootViewController.swift)

After authentification you don't need to init client again, everything is written in keychain

## Usage

There are special structures which can be used, in order to get some information from server. Also there are some models which can be used in order to map the responce. 

There are 7 routers:
* InstagramUserRouter
* InstagramRelationshipRouter
* InstagramMediaRouter
* InstagramCommentRouter
* InstagramLikeRouter
* InstagramLocationRouter
* InstagramTagRouter

Consequently, there are 7 models without suffix 'Router'

Also InstagramAPI gives you an opportunity to have three types of responces:
* InstagramArrayResponce
* InstagramMetaResponce
* InstagramModelResponce

Example:

    let parameter = InstagramUserRouter.UserParameter.id("Your user id")
    let router = InstagramUserRouter.getUser(parameter)
    
    InstagramClient().send(userRouter, completion: { (user: InstagramModelResponse<InstagramUser>?, error: Error?) in 
    
    })

## End of login

If don't need the client, you should end login into a client

    InstagramClient().endLogin()
    
# License
InstagramAPI is released under MIT license,you can see it [here](https://github.com/Den-Ree/InstagramService/blob/master/LICENSE)

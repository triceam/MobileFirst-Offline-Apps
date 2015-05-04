#MobileFirst & Bluemix Apps that Work as Well Offline as they do Online

In the dynamic and ever-changing realm of mobile, context is critical to the success of your applications. Users may be at home sitting on the couch, or they could be on top of a mountain with very limited connectivity. There’s no way to predict where someone will be when they’re using your app, and as many of us painfully know already, there is never a case when you are always online on your mobile devices.

Well, this doesn’t always have to be a problem. Regardless of whether your app is online or offline, it is important that your app does what it needs to do – solve a problem and provide value.

This project contains a sample application called GeoPix, which leverages IBM MobileFirst on Bluemix to capture data and image attachments locally (even offline) and replicate those changes to an online data store so that the user experience is never compromised.

Key concepts demonstrated in these materials:
* User authentication using the Advanced Mobile Access service
* App logging and intstrumentation using Advanced Mobile Access service
* Using a local data store for offline data access
* Data replication (synchronization) to a remote data store
* Building a web based endpoint on the Node.js infrastructure 

Click the image below to view a comlpete end to end [video-walkthrough of this content](http://www.youtube.com/watch?v=rzFQInkcOPw).  

[![Offline Apps With IBM MobileFirst](http://img.youtube.com/vi/rzFQInkcOPw/0.jpg)](http://www.youtube.com/watch?v=rzFQInkcOPw)

The "iOS-native" folder contains the source code for a complete sample application leveraging this workflow.  The "GeoPix-complete" folder contains a completed project.  The "GeoPix-starter" folder contains a starter application, with all MobileFirst/Bluemix code commented out.  You can follow the steps inside of the "[Step By Step Instructions.pdf](https://github.com/triceam/MobileFirst-Offline-Apps/raw/master/Step%20By%20Step%20Instructions.pdf)" file to setup the backend infrastructure on Bluemix, and setup all code within the "GeoPix-starter" project.  The "Node.js" folder contains a server-side Node.js application that exposes all of this captured data through a web endpoint, in case you want to take advantage of the entire Cloud backend.

If you'd like to learn more about these capabilities, I have provided additional in the blog post at: 
[GeoPix: A sample iOS app powered by IBM MobileFirst for Bluemix](http://www.tricedesigns.com/2015/03/27/geopix-a-native-ios-app-powered-by-ibm-mobilefirst-for-bluemix/)

## Helpful Links

<ul>
<li><a href="https://www.ng.bluemix.net/docs/#starters/mobilefirst/index.html" target="_blank">MobileFirst for Bluemix iOS 8 Documentation</a></li>
<li><a href="https://www.ng.bluemix.net/docs/#services/mobileaccess/index.html" target="_blank">Advanced Mobile Access Documentation</a></li>
<li><a href="https://www.ng.bluemix.net/docs/#services/data/index.html#data" target="_blank">Cloudant/Mobile Data Documentation</a></li>
<li><a href="https://github.com/cloudant/nodejs-cloudant#use-an-api-key" target="_blank">Cloudant Node.js Client</a></li>
</ul>
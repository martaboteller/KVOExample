# KVO Example

<table border=0 bordercolorlight=white>
<tr>
<th width=40%>
<img src="https://github.com/martaboteller/KVOExample/blob/master/KVOExample/resources/kvo.gif?raw=true" width="300" height="450"> 
</th>
<th align="left" width=60%>
  <p>This is a simple example of key-value coding usage.</p>
  
  <p>A simple view has been created with a textField and a tableView.</p>
  <p>
  As soon as something is written at the textField an "inputText" property is alerted (Key-Value Observer).
 
 <p> In this simple example we use the observed value to check if the new contact is already listed at the tableView. And let the user add it only if it does not exist.  </p>
  <p>
  At the same time we enable/disable the "add" button when necessary and display an alert message as soon as the inputText property equals an existing contact. 
  </p>
</th>
</tr>
</table>


&nbsp;

## Deployment

1st step: Define an observation token

```
var inputTextObservationToken: NSKeyValueObservation?
```
&nbsp;

2nd step: create an observable property for the textField
```
@objc dynamic var inputText: String?
```
&nbsp;


3rd step: define observer for new values of the property inputText
```
inputTextObservationToken = observe(\.inputText, options: .new, changeHandler: {(vc,change) in
     guard let updatedInputText = change.newValue as? String else {return}
          if self.contacts.contains(updatedInputText) {
                vc.existingLabel.text = "Contact already exists!"
                self.addButton.isEnabled = false
          }else{
                vc.existingLabel.text = ""
                self.addButton.isEnabled = true
          }
})
```
&nbsp;

4th step: assign the value of textField.text to the observable property
```
@IBAction func textFieldTextDidChange() {
      inputText = textField.text
}
```
&nbsp;

5th step: invalidate the observation token
```
override func viewWillDisappear(_ animated: Bool) {
   super.viewWillDisappear(animated)
   inputTextObservationToken!.invalidate()
}
```

&nbsp;


### Result

Please feel free to send me an email should you need further information.

## Built With

* XCode 10.1
* Swift 4.2
* Platform IOS 12.0

## Versioning

First version finished on Jan 2019.

## Authors

* **Marta Boteller** - [Marta Boteller](https://github.com/martaboteller).


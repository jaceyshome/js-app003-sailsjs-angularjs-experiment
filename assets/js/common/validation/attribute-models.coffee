define [], ->
  DataValidations = DataValidations or {}
  DataValidations["project"] =
    name:
      type: "string"
      required: true
      maxLength: 200

    description:
      type: "string"

    priority:
      type: "boolean"
      defaultsTo: false

    shortLink:
      type: "string"
      unique: true
      maxLength: 24

  DataValidations["user"] =
    name:
      type: "string"
      required: true
      maxLength: 45
      unique: true

    email:
      type: "string"
      email: true
      required: true
      maxLength: 45

    password:
      type: "string"
      required: true
      maxLength: 45

    confirmPassword:
      type: "string"
      required: true
      maxLength: 45
      match: "password"

    online:
      type: "boolean"
      defaultsTo: false

    avator:
      type: "string"
      maxLength: 1000

    isAdmin:
      type: "boolean"
      defaultsTo: false

    shortLink:
      type: "string"
      maxLength: 24
      unique: true

  DataValidations

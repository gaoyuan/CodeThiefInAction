function getInheritedPropertyNames(obj) {
  var props = {};
  while(obj) {
    Object.getOwnPropertyNames(obj).forEach(function(p) {
      props[p] = true;
    });
    obj = Object.getPrototypeOf(obj);
  }
  return Object.getOwnPropertyNames(props);
}

// Example: getInheritedPropertyNames(Date)
// ["name", "valueOf", "bind", "__defineGetter__", "UTC", "length", "propertyIsEnumerable", "__lookupGetter__", "parse", "toString", "toLocaleString", "caller", "isPrototypeOf", "__lookupSetter__", "hasOwnProperty", "apply", "arguments", "prototype", "constructor", "call", "now", "__defineSetter__"]
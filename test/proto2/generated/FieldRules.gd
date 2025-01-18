# Generated by protoc-gen-gdscript. DO NOT EDIT!
extends RefCounted

class_name FieldRules

var required_field: String
var optional_field: String
var repeated_field: Array[String]
var required_message: Dictionary
var optional_message: Dictionary
var repeated_message: Array[Dictionary]

func _init():
    pass

func serialize() -> PackedByteArray:
    var bytes = PackedByteArray()
    if required_field != null:
        bytes.append_array(encode_varint(8))
        bytes.append_array(encode_value(required_field))
    if optional_field != null:
        bytes.append_array(encode_varint(16))
        bytes.append_array(encode_value(optional_field))
    if repeated_field != null:
        for item in repeated_field:
            bytes.append_array(encode_varint(24))
            bytes.append_array(encode_value(item))
    if required_message != null:
        bytes.append_array(encode_varint(32))
        bytes.append_array(encode_value(required_message))
    if optional_message != null:
        bytes.append_array(encode_varint(40))
        bytes.append_array(encode_value(optional_message))
    if repeated_message != null:
        for item in repeated_message:
            bytes.append_array(encode_varint(48))
            bytes.append_array(encode_value(item))
    return bytes

static func encode_value(value) -> PackedByteArray:
    if value is int:
        return encode_varint(value)
    elif value is String:
        return encode_string(value)
    elif value is PackedByteArray:
        return encode_bytes(value)
    elif value is bool:
        return encode_varint(1 if value else 0)
    elif value is float:
        return encode_float(value)
    else:
        return value.serialize()

static func encode_bytes(value: PackedByteArray) -> PackedByteArray:
    var length = encode_varint(value.size())
    length.append_array(value)
    return length

static func encode_float(value: float) -> PackedByteArray:
    var bytes = PackedByteArray()
    bytes.resize(8)
    bytes.encode_float(0, value)
    return bytes

static func encode_varint(value: int) -> PackedByteArray:
    var bytes = PackedByteArray()
    while value > 0:
        var byte = value & 0x7F
        value = value >> 7
        if value:
            byte |= 0x80
        bytes.append(byte)
    return bytes

static func encode_string(value: String) -> PackedByteArray:
    var bytes = value.to_utf8_buffer()
    var length = encode_varint(bytes.size())
    length.append_array(bytes)
    return length

static func encode_length_delimited(value: PackedByteArray) -> PackedByteArray:
    var length = encode_varint(value.size())
    length.append_array(value)
    return length


# Generated by protoc-gen-gdscript. DO NOT EDIT!
extends RefCounted

class_name TreeNode

var value: String
var children: Array[Dictionary]
var parent: Dictionary

func _init():
    pass

func serialize() -> PackedByteArray:
    var bytes = PackedByteArray()
    if value != null:
        bytes.append_array(encode_varint(8))
        bytes.append_array(encode_value(value))
    if children != null:
        for item in children:
            bytes.append_array(encode_varint(16))
            bytes.append_array(encode_value(item))
    if parent != null:
        bytes.append_array(encode_varint(24))
        bytes.append_array(encode_value(parent))
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


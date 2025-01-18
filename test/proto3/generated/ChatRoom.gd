# Generated by protoc-gen-gdscript. DO NOT EDIT!
extends RefCounted

class_name ChatRoom

var Member = preload("ChatRoom_Member.gd")

enum RoomType {
    PUBLIC = 0,
    PRIVATE = 1,
    GROUP = 2,
}

var room_id: String
var name: String
var type: int
var members: Array[Dictionary]
var max_members: int
var is_archived: bool

# Reserved field numbers: 7 to 10

func _init():
    pass

func serialize() -> PackedByteArray:
    var bytes = PackedByteArray()
    if room_id != null:
        bytes.append_array(encode_varint(8))
        bytes.append_array(encode_value(room_id))
    if name != null:
        bytes.append_array(encode_varint(16))
        bytes.append_array(encode_value(name))
    if type != null:
        bytes.append_array(encode_varint(24))
        bytes.append_array(encode_value(type))
    if members != null:
        for item in members:
            bytes.append_array(encode_varint(32))
            bytes.append_array(encode_value(item))
    if max_members != null:
        bytes.append_array(encode_varint(40))
        bytes.append_array(encode_value(max_members))
    if is_archived != null:
        bytes.append_array(encode_varint(48))
        bytes.append_array(encode_value(is_archived))
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


# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: fileclass.proto

import sys
_b=sys.version_info[0]<3 and (lambda x:x) or (lambda x:x.encode('latin1'))
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
from google.protobuf import descriptor_pb2
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='fileclass.proto',
  package='tutorial',
  syntax='proto2',
  serialized_pb=_b('\n\x0f\x66ileclass.proto\x12\x08tutorial\"V\n\x04\x46ile\x12\x0c\n\x04name\x18\x01 \x02(\t\x12\x0c\n\x04size\x18\x02 \x02(\x05\x12\x0f\n\x07\x63ontent\x18\x03 \x01(\t\x12\x0e\n\x06target\x18\x04 \x01(\t\x12\x11\n\treplicate\x18\x05 \x01(\t')
)




_FILE = _descriptor.Descriptor(
  name='File',
  full_name='tutorial.File',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='name', full_name='tutorial.File.name', index=0,
      number=1, type=9, cpp_type=9, label=2,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='size', full_name='tutorial.File.size', index=1,
      number=2, type=5, cpp_type=1, label=2,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='content', full_name='tutorial.File.content', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='target', full_name='tutorial.File.target', index=3,
      number=4, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
    _descriptor.FieldDescriptor(
      name='replicate', full_name='tutorial.File.replicate', index=4,
      number=5, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto2',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=29,
  serialized_end=115,
)

DESCRIPTOR.message_types_by_name['File'] = _FILE
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

File = _reflection.GeneratedProtocolMessageType('File', (_message.Message,), dict(
  DESCRIPTOR = _FILE,
  __module__ = 'fileclass_pb2'
  # @@protoc_insertion_point(class_scope:tutorial.File)
  ))
_sym_db.RegisterMessage(File)


# @@protoc_insertion_point(module_scope)
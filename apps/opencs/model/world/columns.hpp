#ifndef CSM_WOLRD_COLUMNS_H
#define CSM_WOLRD_COLUMNS_H

#include "columnbase.hpp"

namespace CSMWorld
{
    template<typename ESXRecordT>
    struct FloatValueColumn : public Column<ESXRecordT>
    {
        FloatValueColumn() : Column<ESXRecordT> ("Value", ColumnBase::Display_Float) {}

        virtual QVariant get (const Record<ESXRecordT>& record) const
        {
            return record.get().mValue.getFloat();
        }

        virtual void set (Record<ESXRecordT>& record, const QVariant& data)
        {
            ESXRecordT record2 = record.get();
            record2.mValue.setFloat (data.toFloat());
            record.setModified (record2);
        }

        virtual bool isEditable() const
        {
            return true;
        }
    };

    template<typename ESXRecordT>
    struct StringIdColumn : public Column<ESXRecordT>
    {
        StringIdColumn() : Column<ESXRecordT> ("ID", ColumnBase::Display_String) {}

        virtual QVariant get (const Record<ESXRecordT>& record) const
        {
            return record.get().mId.c_str();
        }

        virtual bool isEditable() const
        {
            return false;
        }
    };

    template<typename ESXRecordT>
    struct RecordStateColumn : public Column<ESXRecordT>
    {
        RecordStateColumn() : Column<ESXRecordT> ("*", ColumnBase::Display_Integer) {}

        virtual QVariant get (const Record<ESXRecordT>& record) const
        {
            if (record.mState==Record<ESXRecordT>::State_Erased)
                return static_cast<int> (Record<ESXRecordT>::State_Deleted);

            return static_cast<int> (record.mState);
        }

        virtual void set (Record<ESXRecordT>& record, const QVariant& data)
        {
            record.mState = static_cast<RecordBase::State> (data.toInt());
        }

        virtual bool isEditable() const
        {
            return true;
        }

        virtual bool isUserEditable() const
        {
            return false;
        }
    };

    template<typename ESXRecordT>
    struct FixedRecordTypeColumn : public Column<ESXRecordT>
    {
        int mType;

        FixedRecordTypeColumn (int type)
        : Column<ESXRecordT> ("Record Type", ColumnBase::Display_Integer, 0), mType (type) {}

        virtual QVariant get (const Record<ESXRecordT>& record) const
        {
            return mType;
        }

        virtual bool isEditable() const
        {
            return false;
        }
    };

    /// \attention A var type column must be immediately followed by a suitable value column.
    template<typename ESXRecordT>
    struct VarTypeColumn : public Column<ESXRecordT>
    {
        VarTypeColumn (ColumnBase::Display display) : Column<ESXRecordT> ("Type", display) {}

        virtual QVariant get (const Record<ESXRecordT>& record) const
        {
            return static_cast<int> (record.get().mValue.getType());
        }

        virtual void set (Record<ESXRecordT>& record, const QVariant& data)
        {
            ESXRecordT record2 = record.get();
            record2.mValue.setType (static_cast<ESM::VarType> (data.toInt()));
            record.setModified (record2);
        }

        virtual bool isEditable() const
        {
            return true;
        }
    };

    template<typename ESXRecordT>
    struct VarValueColumn : public Column<ESXRecordT>
    {
        VarValueColumn() : Column<ESXRecordT> ("Value", ColumnBase::Display_Var) {}

        virtual QVariant get (const Record<ESXRecordT>& record) const
        {
            switch (record.get().mValue.getType())
            {
                case ESM::VT_String:

                    return record.get().mValue.getString().c_str(); break;

                case ESM::VT_Int:
                case ESM::VT_Short:
                case ESM::VT_Long:

                    return record.get().mValue.getInteger(); break;

                case ESM::VT_Float:

                    return record.get().mValue.getFloat(); break;

                default: return QVariant();
            }
        }

        virtual void set (Record<ESXRecordT>& record, const QVariant& data)
        {
            ESXRecordT record2 = record.get();

            switch (record2.mValue.getType())
            {
                case ESM::VT_String:

                    record2.mValue.setString (data.toString().toUtf8().constData());
                    break;

                case ESM::VT_Int:
                case ESM::VT_Short:
                case ESM::VT_Long:

                    record2.mValue.setInteger (data.toInt());
                    break;

                case ESM::VT_Float:

                    record2.mValue.setFloat (data.toFloat());
                    break;

                default: break;
            }

            record.setModified (record2);
        }

        virtual bool isEditable() const
        {
            return true;
        }
    };
}

#endif
#ifndef MWGUI_SpellBuyingWINDOW_H
#define MWGUI_SpellBuyingWINDOW_H

#include "windowbase.hpp"
#include "referenceinterface.hpp"

#include "../mwworld/esmstore.hpp"

namespace MyGUI
{
  class Gui;
  class Widget;
}

namespace MWGui
{
    class WindowManager;
}


namespace MWGui
{
    class SpellBuyingWindow : public ReferenceInterface, public WindowBase
    {
        public:
            SpellBuyingWindow();

            void startSpellBuying(const MWWorld::Ptr& actor, int startOffset);

            virtual void exit();

        protected:
            MyGUI::Button* mCancelButton;
            MyGUI::TextBox* mPlayerGold;

            MyGUI::ScrollView* mSpellsView;

            std::map<MyGUI::Widget*, std::string> mSpellsWidgetMap;

            void onCancelButtonClicked(MyGUI::Widget* _sender);
            void onSpellButtonClick(MyGUI::Widget* _sender);
            void onMouseWheel(MyGUI::Widget* _sender, int _rel);
            void addSpell(const ESM::Spell& spell);
            void clearSpells();
            int mLastPos,mCurrentY;

            static const int sLineHeight;

            void updateLabels();

            virtual void onReferenceUnavailable();

            bool playerHasSpell (const std::string& id);

        private:
            static bool sortSpells (const ESM::Spell* left, const ESM::Spell* right);
    };
}

#endif

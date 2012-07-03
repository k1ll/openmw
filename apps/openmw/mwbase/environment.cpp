
#include "environment.hpp"

#include <cassert>

#include "../mwinput/inputmanager.hpp"

#include "../mwscript/scriptmanager.hpp"

#include "../mwsound/soundmanager.hpp"

#include "../mwdialogue/dialoguemanager.hpp"
#include "../mwdialogue/journal.hpp"

#include "../mwmechanics/mechanicsmanager.hpp"

#include "world.hpp"

MWBase::Environment *MWBase::Environment::sThis = 0;

MWBase::Environment::Environment()
: mWorld (0), mSoundManager (0), mScriptManager (0), mWindowManager (0),
  mMechanicsManager (0),  mDialogueManager (0), mJournal (0), mInputManager (0), mFrameDuration (0)
{
    assert (!sThis);
    sThis = this;
}

MWBase::Environment::~Environment()
{
    cleanup();
    sThis = 0;
}

void MWBase::Environment::setWorld (World *world)
{
    mWorld = world;
}

void MWBase::Environment::setSoundManager (MWSound::SoundManager *soundManager)
{
    mSoundManager = soundManager;
}

void MWBase::Environment::setScriptManager (MWScript::ScriptManager *scriptManager)
{
    mScriptManager = scriptManager;
}

void MWBase::Environment::setWindowManager (MWGui::WindowManager *windowManager)
{
    mWindowManager = windowManager;
}

void MWBase::Environment::setMechanicsManager (MWMechanics::MechanicsManager *mechanicsManager)
{
    mMechanicsManager = mechanicsManager;
}

void MWBase::Environment::setDialogueManager (MWDialogue::DialogueManager *dialogueManager)
{
    mDialogueManager = dialogueManager;
}

void MWBase::Environment::setJournal (MWDialogue::Journal *journal)
{
    mJournal = journal;
}

void MWBase::Environment::setInputManager (MWInput::MWInputManager *inputManager)
{
    mInputManager = inputManager;
}

void MWBase::Environment::setFrameDuration (float duration)
{
    mFrameDuration = duration;
}

MWBase::World *MWBase::Environment::getWorld() const
{
    assert (mWorld);
    return mWorld;
}

MWSound::SoundManager *MWBase::Environment::getSoundManager() const
{
    assert (mSoundManager);
    return mSoundManager;
}

MWScript::ScriptManager *MWBase::Environment::getScriptManager() const
{
    assert (mScriptManager);
    return mScriptManager;
}

MWGui::WindowManager *MWBase::Environment::getWindowManager() const
{
    assert (mWindowManager);
    return mWindowManager;
}

MWMechanics::MechanicsManager *MWBase::Environment::getMechanicsManager() const
{
    assert (mMechanicsManager);
    return mMechanicsManager;
}

MWDialogue::DialogueManager *MWBase::Environment::getDialogueManager() const
{
    assert (mDialogueManager);
    return mDialogueManager;
}

MWDialogue::Journal *MWBase::Environment::getJournal() const
{
    assert (mJournal);
    return mJournal;
}

MWInput::MWInputManager *MWBase::Environment::getInputManager() const
{
    assert (mInputManager);
    return mInputManager;
}

float MWBase::Environment::getFrameDuration() const
{
    return mFrameDuration;
}

void MWBase::Environment::cleanup()
{
    delete mInputManager;
    mInputManager = 0;

    delete mSoundManager;
    mSoundManager = 0;

    delete mMechanicsManager;
    mMechanicsManager = 0;

    delete mDialogueManager;
    mDialogueManager = 0;

    delete mJournal;
    mJournal = 0;

    delete mScriptManager;
    mScriptManager = 0;

    delete mWorld;
    mWorld = 0;
}

const MWBase::Environment& MWBase::Environment::get()
{
    assert (sThis);
    return *sThis;
}

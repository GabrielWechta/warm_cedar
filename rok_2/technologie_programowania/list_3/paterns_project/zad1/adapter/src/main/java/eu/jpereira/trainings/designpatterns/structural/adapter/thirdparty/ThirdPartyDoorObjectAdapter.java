package eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty;

import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.CodeMismatchException;
import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.IncorrectDoorCodeException;
import eu.jpereira.trainings.designpatterns.structural.adapter.model.Door;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.ThirdPartyDoor.DoorState;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.ThirdPartyDoor.LockStatus;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotChangeCodeForUnlockedDoor;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotChangeStateOfLockedDoor;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotUnlockDoorException;

public class ThirdPartyDoorObjectAdapter implements Door {

	ThirdPartyDoor thirdPartyDoor;
	

	public ThirdPartyDoorObjectAdapter() {
		this.thirdPartyDoor = new ThirdPartyDoor();
	}

	@Override
	public void changeCode(String oldCode, String newCode, String newCodeConfirmation)
			throws IncorrectDoorCodeException, CodeMismatchException {
		if (newCode.equals(newCodeConfirmation)) {
			if (oldCode.equals(thirdPartyDoor.DEFAULT_CODE)) {
				try {
					thirdPartyDoor.unlock(oldCode);
					thirdPartyDoor.setNewLockCode(newCode);
				} catch (CannotChangeCodeForUnlockedDoor e) {
					e.printStackTrace();
				} catch (CannotUnlockDoorException e) {
					e.printStackTrace();
				}
			} else {
				throw new IncorrectDoorCodeException();
			}
		} else {
			throw new CodeMismatchException();
		}
	}

	@Override
	public void close() {
		try {
			thirdPartyDoor.setState(DoorState.CLOSED);
		} catch (CannotChangeStateOfLockedDoor e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean isOpen() {
		if (thirdPartyDoor.getState() == DoorState.OPEN)
			return true;
		else
			return false;
	}

	@Override
	public void open(String code) throws IncorrectDoorCodeException {
		if (code.equals(thirdPartyDoor.DEFAULT_CODE)) {
			try {
				thirdPartyDoor.unlock(code);
				thirdPartyDoor.setState(DoorState.OPEN);
			} catch (CannotChangeStateOfLockedDoor e) {
				e.printStackTrace();
			} catch (CannotUnlockDoorException e) {
				e.printStackTrace();
			}
		} else
			throw new IncorrectDoorCodeException();

	}

	@Override
	public boolean testCode(String code) {
		try {
			thirdPartyDoor.unlock(code);
			if (thirdPartyDoor.getLockStatus() == LockStatus.UNLOCKED)
				return true;
		} catch (CannotUnlockDoorException e) {
		}
		return false;
	}

}
